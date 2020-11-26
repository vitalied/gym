class Trainee::WorkoutsController < Trainee::BaseController
  # GET /trainee/workouts
  def index
    start_date = Date.parse(params[:start_date]) rescue nil
    end_date = Date.parse(params[:end_date]) rescue nil
    @workouts = Workout.by_trainee(current_trainee.id).where(perform_date: start_date..end_date)

    render json: @workouts
  end
end
