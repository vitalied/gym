require "rails_helper"

RSpec.describe Trainee::WorkoutsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trainee/workouts").to route_to("trainee/workouts#index")
    end
  end
end
