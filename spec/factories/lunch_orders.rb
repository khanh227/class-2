FactoryGirl.define do
  factory :lunch_order do
    order_date { Faker::Date.birthday(18, 65) }
  end
end
