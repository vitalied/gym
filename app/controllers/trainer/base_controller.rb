class Trainer::BaseController < ApplicationController
  before_action :authorize_trainer!

  def current_trainer
    @current_trainer
  end

  private

  def authorize_trainer!
    token = request.headers[:Authorization]
    @current_trainer = Trainer.find_by_token(token)
    raise Authentication::Unauthorized if @current_trainer.blank?
  end
end
