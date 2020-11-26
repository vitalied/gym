class TraineeSerializer < ActiveModel::Serializer
  has_many :trainers
  has_many :workouts

  attributes :id, :first_name, :last_name, :email
end
