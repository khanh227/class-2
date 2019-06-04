FactoryGirl.define do
  factory :menu do
    menu_name { Faker::Food.dish }
    user
  end
end
