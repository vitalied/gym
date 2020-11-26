# == Schema Information
#
# Table name: workout_results
#
#  id           :bigint           not null, primary key
#  workout_id   :bigint           not null
#  exercise_id  :bigint           not null
#  medium_pulse :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_workout_results_on_exercise_id                 (exercise_id)
#  index_workout_results_on_workout_id                  (workout_id)
#  index_workout_results_on_workout_id_and_exercise_id  (workout_id,exercise_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (workout_id => workouts.id)
#
class WorkoutResult < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise

  validates :exercise_id, uniqueness: { scope: :workout_id }
  validates :medium_pulse, presence: true, numericality: { only_integer: true,
                                                           greater_than_or_equal_to: 40,
                                                           less_than_or_equal_to: 220 }
end
