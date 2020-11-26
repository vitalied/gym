# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

trainer1 = Trainer.create!(
  token: 'trainer1_token',
  first_name: 'Trainer',
  last_name: '1',
  area_of_expertise: :fitness
)

trainer2 = Trainer.create!(
  token: 'trainer2_token',
  first_name: 'Trainer',
  last_name: '2',
  area_of_expertise: :yoga
)

trainee1 = Trainee.create!(
  token: 'trainee1_token',
  first_name: 'Trainee',
  last_name: '1',
  email: 'trainee1@example.com'
)

trainee2 = Trainee.create!(
  token: 'trainee2_token',
  first_name: 'Trainee',
  last_name: '2',
  email: 'trainee2@example.com'
)

trainer1.trainees = [trainee1, trainee2]
trainer2.trainees = [trainee1, trainee2]

exercise1 = Exercise.create!(
  name: 'Exercise 1',
  duration: 10
)

exercise2 = Exercise.create!(
  name: 'Exercise 2',
  duration: 15
)

exercise3 = Exercise.create!(
  name: 'Exercise 3',
  duration: 20
)

exercise4 = Exercise.create!(
  name: 'Exercise 4',
  duration: 25
)

workout1 = Workout.create!(
  trainer: trainer1,
  name: 'Workout 1',
  state: Workout::STATE.published,
  exercises: [exercise1, exercise2]
)

workout2 = Workout.create!(
  trainer: trainer1,
  name: 'Workout 2',
  state: Workout::STATE.published,
  exercises: [exercise1, exercise2]
)

workout3 = Workout.create!(
  trainer: trainer2,
  name: 'Workout 3',
  state: Workout::STATE.published,
  exercises: [exercise3, exercise4]
)

workout4 = Workout.create!(
  trainer: trainer2,
  name: 'Workout 4',
  state: Workout::STATE.published,
  exercises: [exercise3, exercise4]
)

workout1.assign_trainee!(trainee1.id, Date.today)
workout2.assign_trainee!(trainee2.id, Date.today)
workout3.assign_trainee!(trainee1.id, Date.today)
workout4.assign_trainee!(trainee2.id, Date.today)

WorkoutResult.create!(
  workout: workout1,
  exercise: exercise1,
  medium_pulse: 100
)
WorkoutResult.create!(
  workout: workout1,
  exercise: exercise2,
  medium_pulse: 110
)
WorkoutResult.create!(
  workout: workout2,
  exercise: exercise1,
  medium_pulse: 120
)
WorkoutResult.create!(
  workout: workout2,
  exercise: exercise2,
  medium_pulse: 130
)

WorkoutResult.create!(
  workout: workout3,
  exercise: exercise3,
  medium_pulse: 100
)
WorkoutResult.create!(
  workout: workout3,
  exercise: exercise4,
  medium_pulse: 110
)
WorkoutResult.create!(
  workout: workout4,
  exercise: exercise3,
  medium_pulse: 120
)
WorkoutResult.create!(
  workout: workout4,
  exercise: exercise4,
  medium_pulse: 130
)
