class WelcomeController < ApplicationController
  def index
    @talks = current_camp.upcoming_talks.limit(3)

    @events = current_camp.events.after(Time.now).limit(3)
    @events = @events.where(:type => nil) # FIXME: Subtype the camp catering events

    @latest_notice = current_camp.notices.last
    @project = Project.order('random()').first
  end
  
  def dashboard
    render :layout => 'dashboard'
    @talks_and_events = current_camp.events.in_progress
    the_rest = current_camp.events.after(Time.now).before(12.hours.from_now)
    @upcoming = the_rest.group_by { |a| (a.start_at + Time.zone.utc_offset + 1.hour).to_i / 6.hours }
  end
  
end
