class TeamsController < ApplicationController
  before_action :require_login
  before_action :set_team, only: [:show, :edit, :update, :destroy]

    def index
        @teams = Team.all
        respond_to do |format|
          format.json { render json: @teams }
          format.html { render :index }
        end
    end

    def new
        @team = Team.new
    end

    def create
        @team = Team.new(team_params)
        if @team.save
            redirect_to team_path(@team)
        else
            redirect_to new_team_path(@team), error: "Error: #{@team.errors.full_messages.join(", ")}"
        end
    end

    def show
        @team = Team.find_by_id(params[:id])
        @players = @team.players
    end

    def edit
    end

    def update
        if @team.update(team_params)
            redirect_to team_path(@team)
        else
            redirect_to edit_team_path(@team), error: "Error: #{@team.errors.full_messages.join(", ")}"
        end
    end


    def destroy
        @team.destroy
        flash[:notice] = "Team record deleted."
        redirect_to teams_path
    end


    private

    def team_params
        params.require(:team).permit(:name, :type_player, :role, :quote, :assignment_ids => [], :assignments_attributes=>[:name, :description, :player_id, :team_id])
    end

    def set_team
        @team = Team.find_by(id: params[:id])
    end
end
