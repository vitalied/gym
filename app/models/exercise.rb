# == Schema Information
#
# Table name: exercises
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  duration   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_exercises_on_name  (name) UNIQUE
#
class Exercise < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
