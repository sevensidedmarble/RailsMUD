FactoryGirl.define do
  factory :actor do
    name     { Faker::Internet.email }
    room_id  1
    max_hp 20
    hp 20
  end
end