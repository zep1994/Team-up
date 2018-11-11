class SessionsController < ApplicationController
  before_action :require_login, only: [:logout]
  before_action :set_player, only: [:home]

  def new
    @player = Player.new
  end

  def home
  end

  def login
      @player = Player.find_by(name: params[:player][:name])
        if @player && @player.authenticate(params[:player][:password])
            session[:player_id] = @player.id
            redirect_to home_path
        else
            redirect_to login_path
        end
  end


def destroy
  session.delete :player_id
  redirect_to root_path
end

private

def set_player
  @player = Player.find_by(:id => session[:player_id])
end


end
