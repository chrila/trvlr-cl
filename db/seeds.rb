## clear DB
Like.delete_all
Comment.delete_all
MediaItem.delete_all
Post.delete_all
Segment.delete_all
Waypoint.delete_all
TripUser.delete_all
Trip.delete_all
Activity.delete_all
Following.delete_all
User.delete_all

# users
20.times do
  User.create!(username: Faker::Internet.username, email: Faker::Internet.email)
end

# activities
# some example activities
activity_examples = [
  'started planning a new trip',
  'wrote a new blog post',
  'uploaded a new photo',
  'started a new trip',
  'finished a trip',
  'cancelled a trip',
  'started following you',
  'liked your post',
  'liked your trip',
  'liked your photo',
  'liked your comment',
  'commented on your trip',
  'commented on your post',
  'commented on your photo'
]

User.all.each do |u|
  rand(1..10).times do
    Activity.create!(user: u, description: activity_examples.sample)
  end
end

# followings
User.all.each do |u|
  Following.create!(user: u, followed_user: User.all.sample)
end

# trips
50.times do
  Trip.create!(title: "#{Faker::Address.country} #{rand(1990..2021)}",
               description: Faker::Hipster.sentence,
               start_date: Faker::Date.between(from: 10.years.ago, to: Date.today),
               end_date: Faker::Date.between(from: 10.years.ago, to: Date.today),
               budget: rand(50.0..999_999.9),
               visibility: Trip.visibilities.values.sample,
               status: Trip.statuses.values.sample)
end

# trip_users
User.all.each do |u|
  TripUser.create!(user: u, trip: Trip.all.sample, role: TripUser.roles.values.sample)
end

# continents
continents = [
  'Europe',
  'Asia',
  'North America',
  'South America',
  'Africa',
  'Australia',
  'Antarctica'
]

# waypoints
Trip.all.each do |t|
  rand(5..10).times do
    Waypoint.create!(trip: t,
                     name: Faker::Address.city,
                     notes: Faker::Hipster.sentence,
                     address: Faker::Address.street_address,
                     country: Faker::Address.country,
                     continent: continents.sample,
                     longitude: Faker::Address.longitude,
                     latitude: Faker::Address.latitude)
  end
end

# segments
Trip.all.each do |t|
  t.waypoints.count.times do |i|
    next unless t.waypoints[i + 1]

    Segment.create!(
      trip: t,
      waypoint_from: t.waypoints[i],
      waypoint_to: t.waypoints[i + 1],
      time_from: Faker::Time.between_dates(from: t.start_date, to: t.end_date, period: :all),
      time_to: Faker::Time.between_dates(from: t.start_date, to: t.end_date, period: :all),
      distance: rand(0.0..999.9),
      status: Segment.statuses.values.sample
    )
  end
end

# posts
20.times do
  Post.create!(waypoint: Waypoint.all.sample, title: Faker::Hipster.sentence(word_count: 3),
               content: Faker::Hipster.paragraph, user: User.all.sample)
end

# media items
20.times do
  MediaItem.create!(post: Post.all.sample, title: Faker::Hipster.sentence(word_count: 3),
                    description: Faker::Hipster.sentence)
end

# comments
50.times do
  commentable = case rand(1..4)
                when 1 then Post.all.sample
                when 2 then Activity.all.sample
                when 3 then Trip.all.sample
                when 4 then MediaItem.all.sample
                end
  Comment.create(title: Faker::Hipster.sentence(word_count: 3), content: Faker::Hipster.paragraph,
                 user: User.all.sample, commentable: commentable)
end

# likes
50.times do
  likeable = case rand(1..5)
             when 1 then Post.all.sample
             when 2 then Activity.all.sample
             when 3 then Trip.all.sample
             when 4 then MediaItem.all.sample
             when 5 then Comment.all.sample
             end
  Like.create(user: User.all.sample, likeable: likeable)
end
