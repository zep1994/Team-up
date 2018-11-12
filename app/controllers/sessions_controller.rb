class SessionsController < ApplicationController
  before_action :require_login, only: [:logout]
  before_action :set_player, only: [:home]

  def new
    @player = Player.new
    render 'login'
  end

  def home
  end

  def login
        if auth_hash = request.env["omniauth.auth"]
        #log in omniauth

        oauth_email = request.env["omniauth.auth"]["email"]
        if @player = Player.find_by(:email => oauth_email)
          session[:player_id] = @player.id
          redirect_to player_path(@player)

        else
          player = Player.new(:email => oauth_email)
          if @player.save
            session[:player_id] = @player.id
            redirect_to player_path(@player)
          else
            redirect_to root_path
          end
        end
    else
      @player = Player.find_by(name: params[:player][:name])
        if @player && @player.authenticate(params[:player][:password])
            session[:player_id] = @player.id
            redirect_to home_path
        else
            redirect_to login_path
        end
      end
  end

  def logout
    if session[:player_id]
        session.clear
        redirect_to login_path
    else
        redirect_to home_path
    end
  end



private

def set_player
  @player = Player.find_by(:id => session[:player_id])
end


end
