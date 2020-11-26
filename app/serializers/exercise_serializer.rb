class ExerciseSerializer < ActiveModel::Serializer
  has_many :workouts

  attributes :id, :name, :duration
end
