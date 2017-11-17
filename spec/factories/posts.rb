FactoryBot.define do
  factory :post do
    title { Faker::StarWars.quote }
  end
end
