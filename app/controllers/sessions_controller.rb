class SessionsController < ApplicationController
  def create
    @user = User.find_by_name(params[:name])
    if @user and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:role] = @user.role
      redirect_to "/#{@user.role}s", notice: "Welcome #{params[:name]}"
    else
      redirect_to login_url, notice: "Invalid user name/password"
    end
  end
  def new
    @user = User.new
    respond_to do |format|
      format.html
    end
  end
  def delete
    session[:user_id] = nil
    session[:role] = nil
    redirect_to login_url
  end
end
