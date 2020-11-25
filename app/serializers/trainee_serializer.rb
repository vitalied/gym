class TraineeSerializer < ActiveModel::Serializer
  has_many :trainers

  attributes :id, :first_name, :last_name, :email
end
