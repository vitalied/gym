require "rails_helper"

RSpec.describe Trainee::TraineesController, type: :routing do
  describe "routing" do
    it "routes to #select_trainer" do
      expect(post: "/trainee/trainees/select_trainer").to route_to("trainee/trainees#select_trainer")
    end
  end
end
