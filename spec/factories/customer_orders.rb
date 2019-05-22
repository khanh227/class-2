FactoryGirl.define do
  factory :customer_order do
    user
    product
    lunch_order
    canceled_at nil
  end
end
