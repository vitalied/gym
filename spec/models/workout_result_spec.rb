require 'rails_helper'

RSpec.describe WorkoutResult, type: :model do
  let!(:workout_result) { create :workout_result }

  it { is_expected.to belong_to(:workout) }
  it { is_expected.to belong_to(:exercise) }

  it { is_expected.to validate_uniqueness_of(:exercise_id).scoped_to(:workout_id) }
  it { is_expected.to validate_presence_of(:medium_pulse) }
  it { is_expected.to validate_numericality_of(:medium_pulse)
                        .is_greater_than_or_equal_to(40)
                        .is_less_than_or_equal_to(220)
                        .only_integer }
end
