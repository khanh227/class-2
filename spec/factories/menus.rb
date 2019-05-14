FactoryGirl.define do
  factory :menu do
    menu_date { Faker::Date.forward(20) }
    user
  end
end
