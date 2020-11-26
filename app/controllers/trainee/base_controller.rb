class Trainee::BaseController < ApplicationController
  before_action :authorize_trainee!

  def current_trainee
    @current_trainee
  end

  private

  def authorize_trainee!
    token = request.headers[:Authorization]
    @current_trainee = Trainee.find_by_token(token)
    raise Authentication::Unauthorized if @current_trainee.blank?
  end
end
