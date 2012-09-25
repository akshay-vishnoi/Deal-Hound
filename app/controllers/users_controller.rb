class UsersController < ApplicationController

  helper_method :sort_column, :sort_direction
  
  before_filter(:except => [:new, :create, :forget_password, :change_password, :save_after_forget]) { |conroller| conroller.authorize(false) }
  before_filter(:only => [:index, :destroy]) { |conroller| conroller.authorize(true) }

  def index
    @user = User.find(session[:user_id])
    @users = User.search(params[:search], @user).order(sort_column + " " + sort_direction).paginate page: params[:page], per_page: 10
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by_id(params[:id])
    if @user.nil?
      flash[:error] = "Invalid user"
      redirect_to users_url
    elsif authorize @user.id
      true
    end
  end

  def edit_password
    @user = User.find params[:id]
  end

  def save_password
    @user = User.find_by_id session[:user_id]
    if @user && @user.authenticate(params[:old_password]) && @user.update_password(params)
        redirect_to commodities_url, notice: "#{@user.name}, your password has been updated."
    else
      flash[:error] = "Invalid Current Password" unless @user.errors.any?
      render :edit_password
    end
  end

  def change_password
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate_link == params[:authenticate_link]
      # @user.update_attribute(:authenticate_link, nil)
      flash[:notice] = "Please enter new password"
    else
      flash[:error] = "Invalid request"
      redirect_to login_url
    end
  end

  def save_after_forget
    @user = User.find(params[:id])
    if @user.update_password(params)
      create_session(@user)
      redirect_to commodities_url, notice: "Password changed"
    else
      render :change_password
    end
  end

  def forget_password
    @user = User.find_by_email(params[:email])
    if @user
      authenticate_link = BCrypt::Password.create("tutu")
      @user.update_attribute(:authenticate_link, authenticate_link)
      authentication_path = change_password_users_url + "?email=#{@user.email}&authenticate_link=" + authenticate_link
      PasswordNotifier.reset_password(@user, authentication_path).deliver
      flash.now[:forget_password] = "Authentication link has been sent to your email. Please check it."
    else
      flash.now[:forget_password] = "Email is not registered."
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @user = User.find(params[:id])
    usr = User.find(session[:user_id])
    paramss = wallet_condition usr, @user, params
    nxt_page = usr.admin ? users_url : commodities_url
    if @user.update_attributes!(paramss[:user])
      redirect_to nxt_page, notice: "#{@user.name}'s profile has been updated."
    else
      render :edit
    end
  end

  def wallet_condition(usr, user, params)
    if !usr.admin && !params[:user][:wallet].nil? && usr.id == user.id
      params[:user].delete(:wallet)
      logger.info("#{usr.id} a.k.a. #{usr.name} has tried to access his wallet by unfair means.")
    end
    params
  end

  def create
    params[:user][:wallet] = 0
    @user = User.new(params[:user])
    if @user.save
      create_session(@user)
      redirect_to commodities_url, notice: "Welcome #{params[:name]}"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to request.referrer
  end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end