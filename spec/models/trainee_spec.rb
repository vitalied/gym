require 'rails_helper'

RSpec.describe Trainee, type: :model do
  let!(:trainee) { create :trainee }

  it { is_expected.to have_and_belong_to_many(:trainers) }
  it { is_expected.to have_many(:workouts) }

  it { is_expected.to validate_uniqueness_of(:token) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_length_of(:first_name).is_at_most(100) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:last_name).is_at_most(100) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_most(100) }

  context '.select_trainer!' do
    let!(:trainer) { create :trainer }

    it 'should select trainer' do
      trainee.select_trainer!(trainer.id)
      trainee.reload

      expect(trainee.trainer_ids).to eql([trainer.id])
    end
  end
end
