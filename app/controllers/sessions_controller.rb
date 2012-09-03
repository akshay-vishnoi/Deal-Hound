class SessionsController < ApplicationController
  def create
    @user = User.find_by_name(params[:name])
    respond_to do |format|
      if @user and @user.authenticate(params[:password])
        session[:user_id] = @user.id        
        session[:role] = @user.role
        if @user.role == 'admin'
          format.html { redirect_to admins_url, notice: "Welcome #{params[:name]}" }
        else
          format.html { redirect_to users_url, notice: "Welcome #{params[:name]}" }
        end
      else
        format.html { redirect_to login_url, notice: "Invalid user name/password" }
      end
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
