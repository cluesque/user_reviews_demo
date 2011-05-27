Factory.define :movie do |u|
  u.title { Faker::Lorem.words }
end