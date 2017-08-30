FactoryGirl.define do
  factory :post do
    content     Faker::Lorem.sentence
    latitude    Faker::Address.latitude
    longitude   Faker::Address.longitude
    attachment  Faker::Avatar.image
  end

  factory :post_unvalid, parent: :post do |f|
    content     nil
    latitude    nil
    longitude   nil
    attachment  Faker::Avatar.image
  end
end
