class ApplicationController < ActionController::Base
  protect_from_forgery
  def authorize(role)
    user = User.find_by_id(session[:user_id])
    if (user && (user.role == role)) || (session[:role] == 'admin')
      true
    else
      redirect_to login_url, notice: 'Please log in as a User'
    end
  end
end