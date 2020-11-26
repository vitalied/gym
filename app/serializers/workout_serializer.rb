class WorkoutSerializer < ActiveModel::Serializer
  belongs_to :trainer
  belongs_to :trainee
  has_many :exercises
  has_many :workout_results

  attributes :id, :name, :state, :total_duration, :perform_date
end
