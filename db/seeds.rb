# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

rc11 = Camp.find_by_name('Railscamp 11') || Camp.create(:name => 'Railscamp 11', :location => 'Gold Coast Hinterland, Queensland', :current => true, :time_zone => 'Brisbane', :start_at => '2012-01-13 15:30:00', :end_at => '2012-01-16 10:00:00')
Time.zone = rc11.time_zone

require 'csv'
filename = File.join(Rails.root.to_s, 'db', 'attendees.csv')
puts "Making sure we have some users for #{rc11.name}..."
CSV.foreach(filename, :headers => true) do |row|
  if rc11.users.find_by_email(row['Email']).nil?
    puts "Creating #{row['First Name']} #{row['Last Name']}"
    u = rc11.users.create!(
      :first_name => row['First Name'],
      :last_name => row['Last Name'],
      :email => row['Email'],
      :twitter => row['Twitter']
    )
  end
end
puts "Done with users."

%w(ben.schwarz@gmail.com
ben.schwarz@gmail.com
chris@codesoda.com
daniel@netfox.com
jason@codespike.com
kpitty@cockatoosoftware.com.au
luke@lukehamilton.me
nathan@nathanhoad.net
nigel@logical.com.au
pat@freelancing-gods.com
richie@inspire9.com
sean@kiiii.com
sebastian@vonconrad.com
secoif@gmail.com
tridge@internode.on.net
j.fraser@modsognir.com
).each do |email|
  puts "Setting #{email} as organiser"
  organiser = User.find_by_email(email)
  if organiser
    organiser.attendances.first.update_attribute(:organiser, true)
  end
end
puts 'Done with organisers.'


=begin
puts 'Creating Venues'
['Main Hall', 'Henry Rymill room', 'Safe Refuge Area (Rec Room)', 'Pem Fooks room', 'A. J. Peake room (small)', 'Old House Dining Room', 'Old House Lounge Room'].each { |v| rc10.venues.create!(:name => v) unless rc10.venues.find_by_name(v) }
catering = Venue.find_by_name!('Main Hall')
rec_room = Venue.find_by_name!('Safe Refuge Area (Rec Room)')

puts 'Creating Events'
events = []
events << {:start_at => "2012-01-13 21:45:00", :end_at => "2012-01-14 03:00:00", :name => "Werewolf", :description => "Quite possibly the best game you'll ever play.", :venue => rec_room, :user => ryanbigg}
events << {:start_at => "2012-01-13 20:30:00", :end_at => "2012-01-14 00:10:00", :name => "ScotchFTW", :description => "So much scotch.", :venue => rec_room, :user => lachlanhardy}
# Saturday
events << {:start_at => "2012-01-14 08:00:00", :end_at => "2012-01-14 09:00:00", :name => "Breakfast", :description => "Saturday breakfast"}
events << {:start_at => "2012-01-14 10:30:00", :end_at => "2012-01-14 11:00:00", :name => "Morning Tea", :description => "Saturday morning tea"}
events << {:start_at => "2012-01-14 12:30:00", :end_at => "2012-01-14 13:00:00", :name => "Lunch", :description => "Saturday lunch"}
events << {:start_at => "2012-01-14 15:00:00", :end_at => "2012-01-14 15:30:00", :name => "Afternoon Tea", :description => "Saturday afternoon tea"}
events << {:start_at => "2012-01-14 18:00:00", :end_at => "2012-01-14 19:00:00", :name => "Dinner", :description => "Saturday dinner"}
# Sunday
events << {:start_at => "2012-01-15 08:00:00", :end_at => "2012-01-15 09:00:00", :name => "Breakfast", :description => "Sunday breakfast"}
events << {:start_at => "2012-01-15 10:30:00", :end_at => "2012-01-15 11:00:00", :name => "Morning Tea", :description => "Sunday morning tea"}
events << {:start_at => "2012-01-15 12:30:00", :end_at => "2012-01-15 13:00:00", :name => "Lunch", :description => "Sunday lunch"}
events << {:start_at => "2012-01-15 15:00:00", :end_at => "2012-01-15 15:30:00", :name => "Afternoon Tea", :description => "Sunday afternoon tea"}
events << {:start_at => "2012-01-15 18:00:00", :end_at => "2012-01-15 19:00:00", :name => "Dinner", :description => "Sunday dinner"}
# Monday
events << {:start_at => "2012-01-16 08:00:00", :end_at => "2012-01-16 09:00:00", :name => "Breakfast", :description => "Monday breakfast. It's all over!"}
events << {:start_at => "2012-01-16 09:30:00", :end_at => "2012-01-16 10:30:00", :name => "Game Over", :description => "RailsCamp is over. Time to pack up and head on out."}
events << {:start_at => "2012-01-16 11:00:00", :end_at => "2012-01-16 11:05:00", :name => "Shuttle Bus to the Airport", :description => "If you need the shuttle bus to the airport, they'll be outside the Main Hall building."}

events.each { |e| Event.create!({:camp => rc10, :venue => catering, :user => svc}.merge(e)) }
puts 'Events created.'
=end


puts 'Adding a welcome message'
nr = User.find_by_email("nigel@logical.com.au")
content = <<-EOS
Kickin&rsquo; in the front seat
Sittin&rsquo; in the back seat
Gotta make my mind up
Which seat can I take?

It's Friday, Friday
Gotta get down on Friday
Everybody's lookin&rsquo; forward to the weekend, weekend
Friday, Friday
Gettin&rsquo; down on Friday
Everybody's lookin&rsquo; forward to the weekend

Partyin&rsquo;, partyin&rsquo; (Yeah)
Partyin&rsquo;, partyin&rsquo; (Yeah)
Fun, fun, fun, fun
Lookin&rsquo; forward to the weekend
EOS

Notice.create!(:title => 'Welcome to Woodhouse', :content => content, :camp => rc11, :user => nr)
puts 'Message created.'
puts 'Done!'
