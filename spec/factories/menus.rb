FactoryGirl.define do
  factory :menu do
    menu_date { Faker::Date.between(10.days.ago, Date.today) }
    product_ids { Faker::Lorem.words(1).join(" ") }
    created_by { rand(1..99) }
    user
  end
end