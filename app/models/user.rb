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
class User < ApplicationRecord
  validates :token, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true, length: { maximum: 100 }

  before_validation :set_token, on: :create

  private

  def set_token
    self.token ||= SecureRandom.urlsafe_base64(20).tr('lIO0', 'sxyz')
  end
end
