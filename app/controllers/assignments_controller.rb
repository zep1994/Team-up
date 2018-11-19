class AssignmentsController < ApplicationController
    before_action :require_login, :authenticate_user
    before_action :set_team, only: [:edit, :update]
    before_action :set_assignment, only: [:show, :edit, :update]

    def index
        @assignments = Assignment.all
        if params[:team_id]
            @assignment = Assignment.new(team_id: params[:team_id])
        else
            @assignment = Assignment.new
        end
    end

    def new
        @assignment = Assignment.new(team_id: params[:team_id])
    end

    def create
        @assignment = Assignment.new(assignment_params)
        if @assignment.save
          #add flash message?
          redirect_to assignments_path(@assignment)
        else
            redirect_to new_assignment_path, alert: "Error: #{@assignment.errors.full_messages.join(", ")}"
        end
    end

    def show
        if @assignment
          redirect_to assignment_path(@assignment)
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
