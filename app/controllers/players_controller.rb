class PlayersController < ApplicationController
    before_action :require_login, except: [:new, :create]

    def index
        @players = Player.all
    end

      def new
          @player = Player.new
      end

      def create
          @player = Player.new(player_params)
          if @player.save
              session[:player_id] = @player.id
              redirect_to player_path(@player), notice: "Player sign up was successful."
          else
              redirect_to new_player_path, error: "Error: #{@player.errors.full_messages.join(", ")}"
          end
      end

      def show
          @player = Player.find_by(id: params[:id])
      end

      def edit
          if current_user.leader == true
              # Admins can edit anyone's profile
              @player = Player.find_by(id: params[:id])
          else
              # Everyone else can only edit their own
              @player = Player.find_by(id: current_user.id)
              render :edit
          end
      end

      def update
          if current_user.leader == true
              @player = Player.find_by(id: params[:id])
        else
            @player = current_user
        end

        @player.update(player_params)
        if @player.save
            redirect_to player_path(@player)
        else
            redirect_to edit_player_path(@player), error: "Error: #{@player.errors.full_messages.join(", ")}"
        end
    end

    def destroy
        if current_user.leader == true   # only admins can delete players 
            if Player.find_by(:id => params[:id]) == current_user
                Player.find_by(:id => params[:id]).destroy
                session.clear   # if admin deletes themself, they get logged out
                redirect_to '/'
            elsif Player.find_by(:id => params[:id]).destroy
                Player.find_by(:id => params[:id]).destroy
                flash[:notice] = "Player record deleted."
                redirect_to players_path
            else
                  redirect_to player_path, error: "This action requires leadership"
            end
        end
    end

    private

    def player_params
        params.require(:player).permit(:name, :specialty, :leader, :password, :password_confirmation, :team_ids => [])
    end
end
