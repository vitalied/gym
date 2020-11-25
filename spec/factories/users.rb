FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    factory :trainer, class: Trainer do
      area_of_expertise { %w[yoga fitness strength].sample }
    end

    factory :trainee, class: Trainee do
      email { Faker::Internet.unique.email }
    end
  end
end
