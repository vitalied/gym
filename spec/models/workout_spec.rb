require 'rails_helper'

RSpec.describe Workout, type: :model do
  let!(:workout) { create :workout }

  it { is_expected.to belong_to(:trainer) }
  it { is_expected.to belong_to(:trainee).optional }
  it { is_expected.to have_and_belong_to_many(:exercises) }

  it { is_expected.to validate_presence_of(:trainer_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:trainer_id) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_inclusion_of(:state).in_array(Workout::STATES) }

  context '.total_duration' do
    let!(:exercise1) { create :exercise, workouts: [workout] }
    let!(:exercise2) { create :exercise, workouts: [workout] }

    it 'should calculate total duration of workout' do
      expect(workout.total_duration).to eql(exercise1.duration + exercise2.duration)
    end
  end

  context '.assign_trainee!' do
    let(:perform_date) { Date.today }

    context 'trainer is selected by trainee' do
      let!(:trainee) { create :trainee, trainers: [workout.trainer] }

      it 'should assign trainee to workout' do
        workout.assign_trainee!(trainee.id, perform_date)
        workout.reload
        expect(workout.trainee).to eql(trainee)
        expect(workout.perform_date).to eql(perform_date)
      end
    end

    context 'trainer is not selected by trainee' do
      let!(:trainee) { create :trainee }

      it 'should not assign trainee to workout' do
        workout.assign_trainee!(trainee.id, perform_date)
        workout.reload
        expect(workout.trainee).to be_nil
        expect(workout.perform_date).to be_nil
      end
    end
  end
end
