15.times do
  User.create!(
  email: Faker::Internet.email,
  name: Faker::Name.name,
  password: Faker::Internet.password(8)
  )
end

tester = User.create!(
  email: 'test@test.com',
  name: 'Tester McGee',
  password: '12345678'
)

users = User.all

30.times do
  Topic.create!(
  title: Faker::Internet.domain_word,
  user: users.sample
  )
end

topics = Topic.all


100.times do
  topic_sample = topics.sample
  Bookmark.create!(
  url: Faker::Internet.domain_name,
  topic: topic_sample,
  user: topic_sample.user
  )
end

puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"
