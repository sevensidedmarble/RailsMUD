class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      cookies.encrypted[:user_id] = @user.id
      @user.current_player_id = 1
      redirect_to root_url, notice: 'Thank you for signing up!'
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
