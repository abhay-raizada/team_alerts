require 'spec_helper'
require 'rails_helper'

RSpec.describe ::TeamsController, type: :controller do
    #include RSpec::Rails::ControllerExampleGroup

    describe "Post create" do
        before(:each) do
            Team.delete_all
            Developer.delete_all
        end

        it "creates team" do
          post :create, params: {"team" => {name: "Test Team"}, "developers" => [] }
          expect(Team.first.name).to eq("Test Team")
        end

        it "creates team with developers" do
            post :create, params: {"team" => {name: "Test Team 2"}, "developers": [
                {"name": "someone", "phone_number": "9999999999"},
                {"name": "somebody", "phone_number": "9111111111"}
            ] }
            expect(Team.first.name).to eq("Test Team 2")
            expect(Developer.count).to eq(2)
        end

        it "fails if team not present" do
            post :create, params: {"developers" => [] }
            expect(response.status).to eq(400)
        end

        it "fails if developer params not adequate" do
            post :create, params: {"developers" => [
                {"name": "someone", "phone_number": "9999999999"},
                {"phone_number": "9111111111"}] }
            expect(response.status).to eq(400)
        end
    end
end
