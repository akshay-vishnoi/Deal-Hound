class UsersController < ApplicationController

  helper_method :sort_column, :sort_direction
  
  before_filter(:except => [:new, :create]) { |conroller| conroller.authorize(false) }
  before_filter(:only => [:index, :destroy]) { |conroller| conroller.authorize(true) }

  def index
    @user = User.find(session[:user_id])
    @users = User.search(params[:search], @user).order(sort_column + " " + sort_direction).paginate page: params[:page], per_page: 10
  end

  def new
    @user = User.new
  end

  def edit
  begin
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
      flash[:error] = "Invalid user"
      redirect_to users_url
  else
    if authorize @user.id
      true
    end
  end
  end

  def change_password
    @user = User.find params[:id]
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
    unless params[:user][:wallet].nil?
      params[:user][:wallet] = 0
    end
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        session[:admin] = @user.admin
        format.html { redirect_to commodities_url, notice: "Welcome #{params[:name]}" }
      else
        format.html { render :new }
      end
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