class ApplicationController < ActionController::Base

  protect_from_forgery

  def authorize(admin)
    user = User.find_by_id(session[:user_id])
    if (user && (user.admin == admin)) || (session[:admin] == 1)
      true
    else
      redirect_to login_url, notice: 'Please log in as a User'
    end
  end
end