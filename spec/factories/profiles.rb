FactoryGirl.define do
  factory :profile do
    name Faker::Name.name
    birthday Faker::Date.birthday
    summery Faker::Lorem.sentence
    gender %w[male female other].sample
  end
end
