class Trainer::WorkoutsController < Trainer::BaseController
  before_action :set_workout, only: [:show, :update, :destroy, :assign_trainee]

  # GET /trainer/workouts
  def index
    @workouts = Workout.by_trainer(current_trainer.id)

    render json: @workouts
  end

  # GET /trainer/workouts/:id
  def show
    render json: @workout
  end

  # POST /trainer/workouts
  def create
    @workout = Workout.new(workout_params.merge(trainer_id: current_trainer.id))
    if @workout.save
      render json: @workout, status: :created, location: trainer_workout_path(@workout)
    else
      render_errors(@workout.errors)
    end
  end

  # PATCH/PUT /trainer/workouts/:id
  def update
    if @workout.update(workout_params)
      render json: @workout
    else
      render_errors(@workout.errors)
    end
  end

  # DELETE /trainer/workouts/:id
  def destroy
    @workout.destroy
  end

  # PATCH/PUT /trainer/workouts/:id/assign_trainee
  def assign_trainee
    perform_date = Date.parse(assign_trainee_params[:perform_date]) rescue nil
    if @workout.assign_trainee!(assign_trainee_params[:trainee_id], perform_date)
      render json: @workout
    else
      render_errors(@workout.errors)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_workout
    @workout = Workout.by_trainer(current_trainer.id).find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def workout_params
    params.fetch(:workout, {}).permit(:name, :state, exercise_ids: [])
  end

  def assign_trainee_params
    params.fetch(:workout, {}).permit(:trainee_id, :perform_date)
  end
end
