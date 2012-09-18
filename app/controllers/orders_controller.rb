class OrdersController < ApplicationController
  
  def new
    @user = User.find(session[:user_id])
    @order = @user.orders.new
    @order.mailing_email = @user.email
    @order.full_name = @user.name
    @payments = Order::PAYMENT_MODES
  end

  def create
    @user = User.find(session[:user_id])
    @order = @user.orders.new(params[:order])
    @order.save
    redirect_to request.referrer, notice: "#{params},, #{@order.mailing_email} #{@order.payment_mode}"
  end
end