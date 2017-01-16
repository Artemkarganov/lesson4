FactoryGirl.define do
  factory :user do
    name :Alex
    sequence(:email) { |i| "amail#{i}@mail.com" }
    password 'P@ssw0rd'
  end
end
