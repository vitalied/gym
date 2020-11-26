FactoryBot.define do
  factory :workout do
    trainer
    name { Faker::Lorem.unique.sentence }
    state { 'draft' }

    factory :published_workout do
      state { 'published' }
    end
  end
end
