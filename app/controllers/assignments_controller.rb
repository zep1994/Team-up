class AssignmentsController < ApplicationController
    before_action :require_login, :authenticate_user
    before_action :set_team, only: [:edit, :update, :show, :index, :create, :new]
    before_action :set_assignment, only: [:show, :edit, :update]

    def index
      if params[:team_id]
        #1st you retrieve the team thanks to params[:team_id]
        team = Team.find(params[:team_id])
        #2nd you get all the assignments of this post
        @assignments = team.assignments
      else
        @assignments = Assignment.all
      end
    end

    def new
        @assignment = Assignment.new(team_id: params[:team_id])
    end

    def create
        @assignment = @team.assignments.new(assignment_params)
        if @assignment.save
          respond_to do |format|
                format.json { render json: @assignment.to_json }
                format.html { render :show }
            end
        else
            redirect_to new_assignment_path, alert: "Error: #{@assignment.errors.full_messages.join(", ")}"
        end
    end

    def show
      if @assignment
        team = Team.find(params[:team_id])
        @assignment = team.assignments.find(params[:id])
          respond_to do |format|
            format.json { render json: @assignment }
            format.html { render :show }
          end
        else
            redirect_to new_assignment_path, notice: "That team does not currently have an assignment, create one here."
        end
    end

    def edit
    end

    def update
        if @assignment.update(assignment_params)
            redirect_to team_assignment_path(params[:assignment][:team_id])
        else
            redirect_to edit_team_assignment_path(@assignment), alert: "Error: #{@assignment.errors.full_messages.join(", ")}"
        end
    end

    def destroy
        Assignment.find_by(:id => params[:id]).destroy
        flash[:notice] = "Assignment deleted."
        redirect_to assignments_path
    end


    private

    def assignment_params
        params.require(:assignment).permit(:name, :description, :player_id, :team_id)
    end

    def set_assignment
        @assignment = Assignment.find_by(:team_id => params[:team_id], :id => params[:id])
    end

    def set_team
        @team = Team.find_by(id: params[:team_id])
    end
end
