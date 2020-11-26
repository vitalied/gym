require "rails_helper"

RSpec.describe Trainer::TraineesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trainer/trainees").to route_to("trainer/trainees#index")
    end
  end
end
