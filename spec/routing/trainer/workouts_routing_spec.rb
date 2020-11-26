require "rails_helper"

RSpec.describe Trainer::WorkoutsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trainer/workouts").to route_to("trainer/workouts#index")
    end

    it "routes to #show" do
      expect(get: "/trainer/workouts/1").to route_to("trainer/workouts#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/trainer/workouts").to route_to("trainer/workouts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/trainer/workouts/1").to route_to("trainer/workouts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/trainer/workouts/1").to route_to("trainer/workouts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/trainer/workouts/1").to route_to("trainer/workouts#destroy", id: "1")
    end

    it "routes to #assign_trainee" do
      expect(put: "/trainer/workouts/1/assign_trainee").to route_to("trainer/workouts#assign_trainee", id: "1")
    end
  end
end
