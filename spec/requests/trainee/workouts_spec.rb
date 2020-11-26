require 'rails_helper'

RSpec.describe 'Trainee::Workouts', type: :request do
  context 'unauthorized' do
    context 'GET /index' do
      it 'should return unauthorized status' do
        get trainee_workouts_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'authorized' do
    let!(:trainer) { create :trainer }
    let!(:trainee) { create :trainee, trainers: [trainer] }
    let!(:workout) { create :workout, trainer: trainer, trainee: trainee, perform_date: Date.today }
    let!(:workout2) { create :workout, trainer: trainer, trainee: trainee, perform_date: Date.today + 10 }
    let(:token) { trainee.token }

    context 'GET /trainee/workouts' do
      let(:params) { nil }

      before do
        get trainee_workouts_path(params), headers: token_headers
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns expected data' do
        expect(body.size).to eql(2)
        expect(body.first[:id]).to eql(workout.id)
        expect(body.last[:id]).to eql(workout2.id)
      end

      context 'perform date filters' do
        let(:params) { { start_date: start_date, end_date: end_date } }

        context 'when all workouts are included in date interval' do
          let(:start_date) { Date.today }
          let(:end_date) { Date.today + 10 }

          it 'returns expected data' do
            expect(body.size).to eql(2)
            expect(body.first[:id]).to eql(workout.id)
            expect(body.last[:id]).to eql(workout2.id)
          end
        end

        context 'when only first workout is included in date interval' do
          let(:start_date) { Date.today }
          let(:end_date) { Date.today + 5 }

          it 'returns expected data' do
            expect(body.size).to eql(1)
            expect(body.first[:id]).to eql(workout.id)
          end
        end

        context 'when only second workout is included in date interval' do
          let(:start_date) { Date.today + 5 }
          let(:end_date) { Date.today + 10 }

          it 'returns expected data' do
            expect(body.size).to eql(1)
            expect(body.first[:id]).to eql(workout2.id)
          end
        end

        context 'when no workouts are included in date interval' do
          let(:start_date) { Date.today + 15 }
          let(:end_date) { Date.today + 15 }

          it 'returns expected data' do
            expect(body.size).to be_zero
          end
        end

        context 'when only start_date is set' do
          let(:start_date) { Date.today + 5 }
          let(:end_date) { nil }

          it 'returns expected data' do
            expect(body.size).to eql(1)
            expect(body.first[:id]).to eql(workout2.id)
          end
        end

        context 'when only end_date is set' do
          let(:start_date) { nil }
          let(:end_date) { Date.today + 5 }

          it 'returns expected data' do
            expect(body.size).to eql(1)
            expect(body.first[:id]).to eql(workout.id)
          end
        end
      end
    end
  end
end
