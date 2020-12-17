class TeamsController < ApplicationController
    def create
        # sample_request =
        # {"team":
        #     {"name": "claims"},
        #     "developers": [
        #         {"name": "someone", "phone_number": "9999999999"},
        #         {"name": "somebody", "phone_number": "9111111111"}
        #     ]
        # }
        return render json: {},status: :bad_request unless check_params
        team = Team.create! name: params[:team][:name]
        developer_params = params[:developers] || []
        developer_params = developer_params.map do |dev|
            dev[:team_id] = team.id
            dev[:created_at] = Time.now
            dev[:updated_at] = Time.now
            dev
        end
        developers = Developer.insert_all(developer_params) if developer_params.present?
        render json: {team: team, developers: developers}
    end

    def check_params
        return false unless params[:team].present?
        developers = params[:developers] || []
        return developers.all? {|dev| dev[:name].present? && dev[:phone_number].present?}
    end
end