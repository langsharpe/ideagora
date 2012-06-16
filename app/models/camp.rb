class Camp < ActiveRecord::Base
  include Timeboxed
  
  has_many :attendees, :class_name => 'Attendance'
  has_many :users, :through => :attendees
  has_many :notices
  has_many :venues
  has_many :talks, :through => :venues
  has_many :events

  validates_presence_of :name, :current, :time_zone

  # TODO if one camp is enabled, all others should be disabled

  def to_s
    name
  end

  def current?
    !! current
  end

  def self.current
    where(:current => true).first
  end

  def talks_by_day
    #TODO test me
    #OPTIMIZE: this is ghetto and could be done nicer in sql instead of ruby, but this is quick and dirty for now
    returning ActiveSupport::OrderedHash.new do |tbd|
      (start_at.to_date..end_at.to_date).each do |date|
        tbd[date] = talks.for_day(date)
      end
    end
  end

  def upcoming_talks
    talks.after(Time.now).before(end_at)
  end

  def grouped_upcoming_talks
    upcoming_talks.group_by(&:session)
  end
  
  def past_talks
    talks.before(Time.now).after(start_at)
  end

  def talks_by_time_and_venue_for_day(day)
    #TODO test me
    #We want to return an ordered hash like { :time => { :venue => :talk } }
    talks_by_time = ActiveSupport::OrderedHash.new

    talks_for_day = talks.for_day(day)
    times = talks_for_day.collect(&:start_at).uniq
    venues = talks_for_day.collect(&:venue).uniq

    #Key up all the times
    times.each do |time|
      talks_by_time[time] = ActiveSupport::OrderedHash.new
    end

    #Slot the talks by time, by venue
    talks_for_day.each do |talk|
      talks_by_time[talk.start_at][talk.venue] = talk
    end

    return talks_by_time
  end

  def talk_hours
    #TODO: decide if we want to move this to a config var, or store it in the db per-camp. discuss with Elle
    10.upto(18).to_a
  end

  def talk_days
    #TODO test me
    first_talk_day = start_at.tomorrow.beginning_of_day
    last_talk_day = end_at.yesterday.beginning_of_day
    number_of_days_with_talks = ((last_talk_day.end_of_day - first_talk_day).seconds / 1.day).to_i

    days = []
    number_of_days_with_talks.times {|i| days << first_talk_day.to_date + i.days}
    return days
  end

end
