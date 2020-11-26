class Trainer::TraineesController < Trainer::BaseController
  # GET /trainer/trainees
  def index
    @trainees = current_trainer.trainees

    render json: @trainees
  end
end
