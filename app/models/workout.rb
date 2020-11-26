# == Schema Information
#
# Table name: workouts
#
#  id           :bigint           not null, primary key
#  trainer_id   :bigint           not null
#  trainee_id   :bigint
#  name         :string           not null
#  state        :string           not null
#  perform_date :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_workouts_on_trainee_id           (trainee_id)
#  index_workouts_on_trainer_id           (trainer_id)
#  index_workouts_on_trainer_id_and_name  (trainer_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (trainee_id => users.id)
#  fk_rails_...  (trainer_id => users.id)
#
class Workout < ApplicationRecord
  belongs_to :trainer
  belongs_to :trainee, optional: true
  has_and_belongs_to_many :exercises
  has_many :workout_results

  STATES = %w[draft published].freeze
  STATE = Struct.new(*STATES.map(&:to_sym)).new(*STATES)

  scope :by_trainer, -> (trainer_id) { where(trainer_id: trainer_id) }
  scope :by_trainee, -> (trainee_id) { where(trainee_id: trainee_id) }

  validates :trainer_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :trainer_id }
  validates :state, presence: true, inclusion: STATES
  validates :perform_date, presence: true, if: -> { trainee_id.present? }

  def total_duration
    self.exercises.sum(:duration)
  end

  def assign_trainee!(trainee_id, perform_date)
    trainee = trainer.trainees.where(id: trainee_id)
    if trainee.exists?
      self.update!(trainee_id: trainee_id, perform_date: perform_date)
    else
      self.errors.add(:trainee_id, 'Cannot find trainee!')
      false
    end
  end
end
