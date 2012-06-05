class WelcomeController < ApplicationController
  def index
    @talks = current_camp.upcoming_talks.limit(3)

    @events = current_camp.events.after(Time.now).limit(3)
    @events = @events.where(:type => nil) # FIXME: Subtype the camp catering events

    @latest_notice = current_camp.notices.last
    @project = Project.order('random()').first
  end
  
  def dashboard
    @talks_and_events = current_camp.events.in_progress
    @upcoming = current_camp.events.after(Time.now).before(12.hours.from_now)
    render :layout => 'dashboard'
  end
  
end
