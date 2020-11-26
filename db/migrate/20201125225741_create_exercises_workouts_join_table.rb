class CreateExercisesWorkoutsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :exercises, :workouts do |t|
      t.index :exercise_id
      t.index :workout_id
    end
    add_foreign_key :exercises_workouts, :exercises
    add_foreign_key :exercises_workouts, :workouts
  end
end
