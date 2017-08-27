FactoryGirl.define do
  factory :user do |f|
    email    { Faker::Internet.email }
    password { "123456" }
  end

  factory :password_blank, parent: :user do |f|
    f.password nil
  end

  factory :email_balnk, parent: :user do |f|
    f.email    nil
  end

  factory :blank_params, parent: :user do |f|
    f.email    nil
    f.password nil
  end

  factory :password_invalid, parent: :user do |f|
    f.password { "123" }
  end

  factory :email_invalid, parent: :user do |f|
    f.email    { "test@test." }
  end

  factory :invalid_params, parent: :user do |f|
    f.email    { "test@test." }
    f.password { "123" }
  end

  factory :taken_email, parent: :user do |f|
    f.email    { "test@test.test" }
    f.password { "123456" }
  end
end
