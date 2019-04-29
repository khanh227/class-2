FactoryGirl.define do
  factory :product do 
    name { "#{Faker::Lorem.word} #{SecureRandom.hex}" }
    user
    description "must buy"
    price "15000"
    enabled "true"
    quatity "9"
    end
end
