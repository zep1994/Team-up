class SessionsController < ApplicationController
  before_action :require_login, only: [:logout]
  before_action :set_player, only: [:home]

  def new
    @player = Player.new
    render 'login', notice: "Successfully Signed Up."
  end

  def home
  end

    def login
        if auth_hash = request.env["omniauth.auth"]
        oauth_email = request.env["omniauth.auth"]["email"]
        if @player = Player.find_by(:email => oauth_email)
          session[:player_id] = @player.id
          redirect_to player_path(@player), notice: "Successfully Logged In."
        else
          player = Player.new(:email => oauth_email)
          if @player.save
            session[:player_id] = @player.id
            redirect_to player_path(@player), notice: "Successfully Logged In."
          else
            redirect_to root_path
          end
        end
    else
      @player = Player.find_by(name: params[:player][:name])
        if @player && @player.authenticate(params[:player][:password])
            session[:player_id] = @player.id
            redirect_to home_path, notice: "Successfully Logged In."
        else
            redirect_to login_path, notice: "There was an error, please try again."
        end
      end
    end

  def logout
    if session[:player_id]
        session.clear
        redirect_to login_path, notice: "Successfully Logged Out."
    else
        redirect_to home_path, notice: "There was an Error logging out."
    end
  end



private

def set_player
  @player = Player.find_by(:id => session[:player_id])
end


end
