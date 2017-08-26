FactoryGirl.define do
  factory :auth_token do
    token "MyString"
    refresh_token "MyString"
    token_expires_at "2017-08-26 12:42:30"
    refresh_token_expires_at "2017-08-26 12:42:30"
    tokenable nil
  end
end
