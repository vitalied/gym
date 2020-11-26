require 'rails_helper'

RSpec.describe 'Trainer::Workouts', type: :request do
  context 'unauthorized' do
    context 'GET /trainer/workouts' do
      it 'should return unauthorized status' do
        get trainer_workouts_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'authorized' do
    let!(:trainer) { create :trainer }
    let(:trainee) { create :trainee, trainers: [trainer] }
    let(:exercise) { create :exercise }
    let!(:workout) { create :workout, trainer: trainer }
    let(:valid_params) { { name: 'New Workout', state: Workout::STATE.draft, exercise_ids: [exercise.id] } }
    let(:invalid_params) { { name: nil, state: nil } }
    let(:token) { trainer.token }

    context 'GET /trainer/workouts' do
      before do
        get trainer_workouts_path, headers: token_headers
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns expected data' do
        expect(body.first[:id]).to eql(workout.id)
      end
    end

    context 'GET /trainer/workouts/:id' do
      context 'when Workout entity exist' do
        before do
          get trainer_workout_path(workout.id), headers: token_headers
        end

        it 'returns a success response' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns expected data' do
          expect(body[:id]).to eql(workout.id)
          expect(body_errors).not_to be_present
        end
      end

      context 'when Workout entity does not exist' do
        before do
          get trainer_workout_path(:fake_id), headers: token_headers
        end

        it 'returns an error response' do
          expect(response).to have_http_status(:not_found)
          expect(body_errors).to be_present
        end
      end
    end

    context 'POST /trainer/workouts' do
      context 'with valid params' do
        let(:post_request) { post trainer_workouts_path, params: { workout: valid_params }, headers: token_headers, as: :json }

        it 'creates a new Workout entity' do
          expect { post_request }.to change(Workout, :count).by(1)
        end

        it 'renders a JSON response with the new Workout entity' do
          post_request

          expect(response).to have_http_status(:created)
          expect(body_errors).not_to be_present
          expect(response.location).to be_present

          expect(body[:trainer][:id]).to eql(trainer.id)
          expect(body[:name]).to eql(valid_params[:name])
          expect(body[:state]).to eql(valid_params[:state])
          expect(body[:exercises].first[:id]).to eql(exercise.id)
        end
      end

      context 'with invalid parameters' do
        let(:post_request) { post trainer_workouts_path, params: { workout: invalid_params }, headers: token_headers, as: :json }

        it 'does not create a new Workout entity' do
          expect { post_request }.not_to change(Workout, :count)
        end

        it 'renders a JSON response with errors for the new entity' do
          post_request

          expect(response).to have_http_status(:unprocessable_entity)
          expect(body_errors).to be_present
        end
      end
    end

    context 'PATCH/PUT /trainer/workouts/:id' do
      context 'with valid params' do
        before do
          put trainer_workout_path(workout), params: { workout: valid_params }, headers: token_headers, as: :json
        end

        it 'updates the Workout entity' do
          workout.reload

          expect(workout.name).to eql(valid_params[:name])
          expect(workout.state).to eql(valid_params[:state])
          expect(workout.exercises.first.id).to eql(exercise.id)
        end

        it 'renders a JSON response with the updated Workout entity' do
          expect(response).to have_http_status(:ok)
          expect(body_errors).not_to be_present

          expect(body[:trainer][:id]).to eql(trainer.id)
          expect(body[:name]).to eql(valid_params[:name])
          expect(body[:state]).to eql(valid_params[:state])
          expect(body[:exercises].first[:id]).to eql(exercise.id)
        end
      end

      context 'with invalid params' do
        before do
          put trainer_workout_path(workout), params: { workout: invalid_params }, headers: token_headers, as: :json
        end

        it 'renders a JSON response with errors for the Workout entity' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(body_errors).to be_present
        end
      end

      context 'when Workout entity does not exist' do
        before do
          put trainer_workout_path(:fake_id), headers: token_headers, as: :json
        end

        it 'returns a failure response containing errors' do
          expect(response).to have_http_status(:not_found)
          expect(body_errors).to be_present
        end
      end
    end

    context 'DELETE /trainer/workouts/:id' do
      context 'when Workout entity exist' do
        let(:delete_request) { delete trainer_workout_path(workout), headers: token_headers, as: :json }

        it 'deletes the Workout entity' do
          expect { delete_request }.to change(Workout, :count).by(-1)
        end

        it 'returns a success response' do
          delete_request

          expect(response).to have_http_status(:no_content)
          expect(body_errors).not_to be_present
        end
      end

      context 'when Workout entity does not exist' do
        let(:delete_request) { delete trainer_workout_path(:fake_id), headers: token_headers, as: :json }

        it 'does not  delete the Workout entity' do
          expect { delete_request }.not_to change(Workout, :count)
        end

        it 'returns a failure response containing errors' do
          delete_request

          expect(response).to have_http_status(:not_found)
          expect(body_errors).to be_present
        end
      end
    end

    context 'PATCH/PUT /trainer/workouts/:id/assign_trainee' do
      let(:perform_date) { Date.today }
      let(:valid_params) { { trainee_id: trainee.id, perform_date: perform_date } }
      let(:invalid_params) { { trainee_id: nil, perform_date: nil } }

      context 'with valid params' do
        before do
          put assign_trainee_trainer_workout_path(workout), params: { workout: valid_params }, headers: token_headers, as: :json
        end

        it 'assign the Workout entity to the trainee' do
          workout.reload

          expect(workout.trainee).to eql(trainee)
          expect(workout.perform_date).to eql(perform_date)
        end

        it 'renders a JSON response with the updated Workout entity' do
          expect(response).to have_http_status(:ok)
          expect(body_errors).not_to be_present

          expect(body[:trainee][:id]).to eql(trainee.id)
          expect(body[:perform_date]).to eql(perform_date.to_s)
        end
      end

      context 'with invalid params' do
        before do
          put assign_trainee_trainer_workout_path(workout), params: { workout: invalid_params }, headers: token_headers, as: :json
        end

        it 'renders a JSON response with errors for the Workout entity' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(body_errors).to be_present
        end
      end

      context 'when Workout entity does not exist' do
        before do
          put assign_trainee_trainer_workout_path(:fake_id), headers: token_headers, as: :json
        end

        it 'returns a failure response containing errors' do
          expect(response).to have_http_status(:not_found)
          expect(body_errors).to be_present
        end
      end
    end
  end
end
