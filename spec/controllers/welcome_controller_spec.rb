require 'spec_helper'

describe WelcomeController do
 
  let(:camp) { Camp.current || Camp.make! }
  let(:library) { Venue.make! :camp => camp }
  let(:study) { Venue.make! :camp => camp }
  
  describe '#index' do
    
        
    it "collects talks and groups them by venue" do
      pending 'changed in rcx version'
      
      Talk.make! :camp => camp, :venue => library, :start_at => Time.zone.now
      Talk.make! :camp => camp, :venue => library, :start_at => 1.minute.from_now
      
      
      Talk.make! :camp => camp, :venue => study, :start_at => Time.zone.now
      Talk.make! :camp => camp, :venue => study, :start_at => 2.days.from_now
      
      get :index
      
      # puts assigns[:todays_talks_by_venue_id].inspect
      
      # assigns[:todays_talks_by_venue_id][library.id].length.should == 2
      # assigns[:todays_talks_by_venue_id][study.id].length.should   == 1
    end
  end
  
  describe "#dashboard" do
    it "displays the page" do
      camp
      get :dashboard
      response.should be_success
    end
    it "has all the current events and talks" do
      Talk.make! :camp => camp, :venue => library, :start_at => Time.zone.now
      Talk.make! :camp => camp, :venue => library, :start_at => Time.zone.now
      Event.make! :camp => camp, :venue => library, :start_at => Time.zone.now
      get :dashboard
      assigns(:talks_and_events).length.should == 3

    end
  end
end
