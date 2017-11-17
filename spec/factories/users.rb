FactoryBot.define do
  factory :user do
    name { Faker::Zelda.character }
  end
end
