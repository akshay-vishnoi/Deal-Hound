class SessionsController < ApplicationController

  def create
    @user = User.find_by_name(params[:name])
    if @user && @user.authenticate(params[:password])
      nxt_page = (@user.admin == 1) ? admins_url : users_url
      session[:user_id] = @user.id
      session[:admin] = @user.admin
      redirect_to nxt_page, notice: "Welcome #{params[:name]}"
    else
      flash[:error] = "Invalid user name/password"
      redirect_to login_url
    end
  end

  def new
    @user = User.new
  end

  def delete
    session[:user_id] = nil
    session[:admin] = nil
    redirect_to login_url
  end
end
