require 'rails_helper'

RSpec.describe Trainer, type: :model do
  let!(:trainer) { create :trainer }

  it { is_expected.to have_and_belong_to_many(:trainees) }
  it { is_expected.to have_many(:workouts) }

  it { is_expected.to validate_uniqueness_of(:token) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_length_of(:first_name).is_at_most(100) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:last_name).is_at_most(100) }
  it { is_expected.to validate_presence_of(:area_of_expertise) }
end
