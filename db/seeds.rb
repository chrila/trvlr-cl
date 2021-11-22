# frozen_string_literal: true

## clear DB
# Like.delete_all
# Comment.delete_all
# MediaItem.delete_all
# Post.delete_all
# Segment.delete_all
# Waypoint.delete_all
# TripUser.delete_all
# Trip.delete_all
# Activity.delete_all
# Following.delete_all
# User.delete_all

def create_waypoint(trip, country, previous_waypoint)
  lat_max, lat_min, lon_max, lon_min = nil

  if previous_waypoint
    # if previous waypoint is given, choose next waypoint close to it
    lat_max = previous_waypoint.latitude + 2
    lat_min = previous_waypoint.latitude - 2
    lon_max = previous_waypoint.longitude + 2
    lon_min = previous_waypoint.longitude - 2
  else
    # if not, the waypoint shall be somewhere in the country
    lat_max = country.max_latitude
    lat_min = country.min_latitude
    lon_max = country.max_longitude
    lon_min = country.min_longitude
  end

  Waypoint.create!(
    trip: trip,
    name: Faker::Address.city,
    notes: Faker::Hipster.sentence,
    address: Faker::Address.street_address,
    country: country.alpha2,
    continent: country.continent,
    latitude: rand(lat_min..lat_max),
    longitude: rand(lon_min..lon_max)
  )
end

def create_segment(trip, wp_from, wp_to, previous_segment)
  time_from = previous_segment ? previous_segment.time_to : trip.start_date
  time_to = Faker::Time.between_dates(from: time_from, to: trip.end_date, period: :all)
  status =
    if time_from > Date.today
      Segment.statuses["segment_open"]
    elsif time_to < Date.today
      Segment.statuses["segment_finished"]
    else
      Segment.statuses["segment_active"]
    end

  Segment.create!(
    trip: trip,
    waypoint_from: wp_from,
    waypoint_to: wp_to,
    time_from: time_from,
    time_to: time_to,
    distance: wp_from.distance_to(wp_to).round(2),
    status: status,
    means_of_travel: MeansOfTravel.all.sample
  )
end

def random_quote
  # randomly choose type of quote
  quote = rand(1..4)
  case quote
  when 1 then Faker::TvShows::MichaelScott.quote
  when 2 then Faker::TvShows::GameOfThrones.quote
  when 3 then Faker::TvShows::Simpsons.quote
  when 4 then Faker::TvShows::HowIMetYourMother.quote
  end
end

# users
20.times do
  u = User.new(username: Faker::Internet.username, email: Faker::Internet.email, password: "123456")
  temp_file = Down.download("https://picsum.photos/500")
  u.avatar.attach(io: temp_file, filename: "avatar-#{u.email}.jpg")
  u.save!
end

# followings
User.all.each do |u|
  Following.create!(user: u, followed_user: User.all.sample)
end

# means of travel
MeansOfTravel.create(name: "Motorbike")
MeansOfTravel.create(name: "Car")
MeansOfTravel.create(name: "Aeroplane")
MeansOfTravel.create(name: "Ship")
MeansOfTravel.create(name: "Bicycle")
MeansOfTravel.create(name: "Foot")

# trips
30.times do
  country = ISO3166::Country.new(Faker::Address.country_code)
  start_date = Faker::Date.between(from: 10.years.ago, to: Date.today)
  end_date = Faker::Date.between(from: start_date, to: 1.year.from_now)
  status =
    if start_date > Date.today
      Trip.statuses["trip_draft"]
    elsif end_date < Date.today
      rand(1..5) < 4 ? Trip.statuses["trip_finished"] : Trip.statuses["trip_cancelled"]
    else
      Trip.statuses["trip_active"]
    end

  trip = Trip.create!(
    title: "#{country.subregion} #{start_date.year}",
    description: Faker::Hipster.sentence,
    start_date: start_date,
    end_date: end_date,
    budget: rand(50.0..999_999.9).round(2),
    visibility: Trip.visibilities.values.sample,
    status: status
  )

  # trip_users
  rand(1..5).times do
    TripUser.create!(user: User.all.sample, trip: trip, role: TripUser.roles.values.sample)
  end

  # waypoints
  # create first waypoint in starting country
  w = create_waypoint(trip, country, nil)
  rand(5..10).times do
    w = create_waypoint(trip, country, w)

    # posts
    2.times do
      Post.create!(
        waypoint: w, title: Faker::Hipster.sentence(word_count: 2),
        content: Faker::Hipster.paragraph, user: trip.users.sample
      )
    end

    # media items
    2.times do
      m = MediaItem.create!(
        waypoint: w, title: Faker::Hipster.sentence(word_count: 2),
        description: Faker::Hipster.sentence, user: trip.users.sample
      )
      temp_file = Down.download("https://picsum.photos/1000")
      m.photo.attach(io: temp_file, filename: "photo.jpg")
      m.save!

      trip.update(cover_photo: m) unless trip.cover_photo
    end
  end

  # segments
  s = nil
  trip.waypoints.count.times do |i|
    next unless trip.waypoints[i + 1]

    s = create_segment(trip, trip.waypoints[i], trip.waypoints[i + 1], s)
  end
end

# comments
200.times do
  commentable =
    case rand(1..4)
    when 1 then Post.all.sample
    when 2 then Activity.all.sample
    when 3 then Trip.all.sample
    when 4 then MediaItem.all.sample
    end
  Comment.create(content: random_quote, user: User.all.sample, commentable: commentable)
end

# likes
200.times do
  likeable =
    case rand(1..5)
    when 1 then Post.all.sample
    when 2 then Activity.all.sample
    when 3 then Trip.all.sample
    when 4 then MediaItem.all.sample
    when 5 then Comment.all.sample
    end
  Like.create(user: User.all.sample, likeable: likeable)
end

# activities
(User.count * 5).times do
  n = rand(1..6)
  subject =
    case n
    when 1 then Comment.all.sample
    when 2 then MediaItem.all.sample
    when 3 then Post.all.sample
    when 4 then Trip.all.sample
    when 5 then Activity.all.sample
    when 6 then User.all.sample
    end
  action = rand(1..2) == 1 ? "liked" : "commented on"
  action = "started following" if n == 6
  Activity.create!(user: User.all.sample, subject: subject, action: action)
end

# dummy admin user for development
if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password",
                    password_confirmation: "password")
end
