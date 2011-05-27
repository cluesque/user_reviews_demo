Factory.define :book do |u|
  u.title { Faker::Lorem.words }
end