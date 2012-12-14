class SessionsController < ApplicationController

  def create
    @user = User.find_by_user_name(params[:user_name])
    if @user && @user.authenticate(params[:password])
      create_session(@user)
      redirect_to commodities_url, notice: "Welcome #{params[:name]}"
    else
      flash[:error] = "Invalid user name/password"
      redirect_to login_url
    end
  end

  def new
    @user = User.new
  end

  def delete
    reset_session
    redirect_to login_url
  end
end
