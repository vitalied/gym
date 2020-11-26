class WorkoutResultSerializer < ActiveModel::Serializer
  belongs_to :workout
  belongs_to :exercise

  attributes :id, :workout_id, :exercise_id, :medium_pulse
end
