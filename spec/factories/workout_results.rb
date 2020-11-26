FactoryBot.define do
  factory :workout_result do
    workout
    exercise
    medium_pulse { Faker::Number.between(from: 40, to: 220) }
  end
end
