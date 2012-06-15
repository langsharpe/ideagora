class Event < ActiveRecord::Base
  include Timeboxed

  belongs_to :user
  belongs_to :venue
  belongs_to :camp #denormalized from venue because talks start off w/out a venue when a camp is created

  validates_presence_of :camp
  validates_presence_of :user
  validates_presence_of :venue

  scope :after, lambda { |time| where("start_at >= :time", :time => time) }
  scope :before, lambda { |time| where("start_at <= :time", :time => time) }
  scope :for_day, lambda { |day| self.after(day.beginning_of_day).before(day.end_of_day) }
  scope :in_progress, lambda { self.before(Time.zone.now).where("end_at > :time", :time => Time.zone.now) }

  default_scope order(:start_at)

  def self.for_venue(venue)
    where(:venue_id => venue.id)
  end

  def day
    start_at.to_date
  end

end