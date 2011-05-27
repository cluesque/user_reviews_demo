Factory.define :user do |u|
  u.login { Faker::Internet.email }
end