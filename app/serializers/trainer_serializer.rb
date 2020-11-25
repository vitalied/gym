class TrainerSerializer < ActiveModel::Serializer
  has_many :trainees

  attributes :id, :first_name, :last_name, :area_of_expertise
end
