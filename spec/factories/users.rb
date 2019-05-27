FactoryGirl.define do 
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "@ssword-#{SecureRandom.hex(8)}"
  end
end
