FactoryBot.define do
  factory :exercise do
    name { Faker::Lorem.unique.sentence }
    duration { Faker::Number.between(from: 1, to: 10) }
  end
end
