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
class Trainee < User
  has_and_belongs_to_many :trainers, join_table: :trainees_trainers

  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }

  def select_trainer!(trainer_id)
    trainer = Trainer.find_by_id(trainer_id)
    self.trainer_ids = self.trainer_ids | [trainer.id] if trainer.present?
  end
end
