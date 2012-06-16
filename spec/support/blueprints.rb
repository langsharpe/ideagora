require 'machinist/active_record'
require 'faker'

Attendance.blueprint do
  user          { User.make! }
  camp          { Camp.make! }
  organiser     { false }
end

Camp.blueprint do
  name          { 'Railscamp 9' }
  current       { true }
  time_zone     { 'Sydney' }
  start_at      { 1.day.ago.beginning_of_day + 16.hours }
  end_at        { 2.days.from_now.beginning_of_day + 10.hours }
end

Camp.blueprint(:previous) do
  name          { 'Railscamp 8' }
  current       { false }
end

Notice.blueprint do
  title         { Faker::Name.name }
  content       { Faker::Lorem.sentences }
  user          { User.make! }
  camp          { Camp.make! }
end

Project.blueprint do
  name          { Faker::Company.name }
  owner         { User.make! }
end

Event.blueprint do
  name     { Faker::Lorem.words((rand * 8).floor+2).join(" ") }
  description { Faker::Lorem.sentences }
  camp     { object.camp || Camp.current || Camp.make! }
  venue    { Venue.all.sample || Venue.make! }
  user     { User.all.sample || User.make! }
  start_at do
    starting = Camp.current.start_at.to_time
    ending = Camp.current.end_at.to_time
    timestamp = (starting.to_i..ending.to_i).step(3600).sample
    Time.at(timestamp) + (rand * 360).floor.minutes
  end
  end_at   { object.start_at + 1.hour }
end

Talk.blueprint do
  name     { Faker::Lorem.words((rand * 8).floor+2).join(" ") }
  description { Faker::Lorem.sentences }
  camp     { object.camp || Camp.current || Camp.make! }
  venue    { Venue.all.sample || Venue.make! }
  user     { User.all.sample || User.make! }
  start_at do
    starting = Camp.current.start_at.to_time
    ending = Camp.current.end_at.to_time
    timestamp = (starting.to_i..ending.to_i).step(3600).sample
    Time.at(timestamp) + (rand * 360).floor.minutes
  end
  end_at   { object.start_at + 1.hour }
end

Venue.blueprint do
  name { Faker::Lorem.words(1) }
  camp { object.camp || Camp.current || Camp.make! }
end

User.blueprint do
  first_name       { Faker::Name.name }
  last_name        { Faker::Name.name }
  email            { Faker::Internet.email }
  twitter          { Faker::Name.name }
  bio              { Faker::Name.name }
  skill_list       { 'skill_a, skill_b' }
  interest_list    { 'interest_a, interest_b' }
end


Discussion.blueprint do
  # Attributes here
end

Thought.blueprint do
  # Attributes here
end

Question.blueprint do
  # Attributes here
end
