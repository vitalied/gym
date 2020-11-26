require 'rails_helper'

RSpec.describe 'Trainee::Trainees', type: :request do
  context 'unauthorized' do
    context 'POST /trainee/trainees/select_trainer' do
      it 'should return unauthorized status' do
        post select_trainer_trainee_trainees_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'authorized' do
    let!(:trainer) { create :trainer }
    let!(:trainee) { create :trainee }
    let(:token) { trainee.token }

    context 'GET /trainer/trainees' do
      before do
        post select_trainer_trainee_trainees_path, params: { trainer_id: trainer.id }, headers: token_headers, as: :json
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns expected data' do
        expect(body[:trainers].first[:id]).to eql(trainer.id)
      end
    end
  end
end
