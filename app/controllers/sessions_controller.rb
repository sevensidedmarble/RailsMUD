class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    # puts user.email
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies.encrypted[:user_id] = user.id

      # TODO undo hardcoding of player log in
      # when theres time, this system will support multiple players(characters) per user.
      user.current_player_id = 1

      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
