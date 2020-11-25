# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  type              :string           not null
#  token             :string           not null
#  first_name        :string(100)      not null
#  last_name         :string(100)      not null
#  email             :string(100)
#  area_of_expertise :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_token  (token) UNIQUE
#
class Trainer < User
  has_and_belongs_to_many :trainees, join_table: :trainees_trainers

  validates :area_of_expertise, presence: true
end
