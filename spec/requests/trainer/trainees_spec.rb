require 'rails_helper'

RSpec.describe 'Trainer::Trainees', type: :request do
  context 'unauthorized' do
    context 'GET /trainer/trainees' do
      it 'should return unauthorized status' do
        get trainer_trainees_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'authorized' do
    let!(:trainer) { create :trainer }
    let!(:trainee) { create :trainee, trainers: [trainer] }
    let(:token) { trainer.token }

    context 'GET /trainer/trainees' do
      before do
        get trainer_trainees_path, headers: token_headers
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns expected data' do
        expect(body.first[:id]).to eql(trainee.id)
      end
    end
  end
end
