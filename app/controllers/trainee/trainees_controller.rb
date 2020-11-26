class Trainee::TraineesController < Trainee::BaseController
  # POST /trainee/trainees/select_trainer
  def select_trainer
    current_trainee.select_trainer!(params[:trainer_id])

    render json: current_trainee
  end
end
