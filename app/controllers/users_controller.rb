class UsersController < ApplicationController

  before_filter(:except => [:new, :create]) { |conroller| conroller.authorize(false) }
  before_filter(:only => [:index, :destroy]) { |conroller| conroller.authorize(true) }

  def index
    @user = User.find(session[:user_id])
    @users = User.where('user_name != ?', @user.user_name)
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

  def update
    @user = User.find(params[:id])
    usr = User.find(session[:user_id])
    nxt_page = usr.admin ? users_url : commodities_url
    if @user.update_attributes!(params[:user])
      redirect_to nxt_page, notice: "#{@user.name}'s profile has been updated."
    else
      render :edit
    end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html {  }
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
end