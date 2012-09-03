class UsersController < ApplicationController
  before_filter(:except => [:new, :create]) { |conroller| conroller.authorize("user") }
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
    if @user.save
      format.html { redirect_to users_path }
    end
    end
  end
end
