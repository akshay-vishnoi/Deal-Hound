class OrdersController < ApplicationController

  before_filter() { |controller| controller.authorize(session[:admin])}
  helper_method :sort_column, :sort_direction
  def new
    @user = User.find(session[:user_id])
    @cart = @user.cart
    if @cart.line_items.any?
      @order = @user.orders.new
      @order.mailing_email = @user.email
      @order.full_name = @user.name
      @payments = Order::PAYMENT_MODES
      @order.address = Address.new if @user.cart.voucher
    else
      flash[:error] = "There is no item in cart"
      redirect_to commodities_url
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    # redirect_to request.referrer, notice: params[:order][:status]
    if @order.update_attribute(:status, params[:order][:status])
      flash[:notice] = "Now Order no. #{@order.id} is #{@order.status_to_s}."
    else
      flash[:error] = "Error while saving order. Please check it again."
    end
    redirect_to orders_url
  end

  def index
    user = User.find_by_id(session[:user_id])
    if user && user.admin
      find_by_attr = params[:search]
    else
      find_by_attr = session[:user_id]
    end
    @orders = Order.search(find_by_attr, sort_column, sort_direction, params[:page], user.admin)
  end

  def create
    @user = User.find(session[:user_id])
    @order = @user.orders.new(params[:order])
    @order.address = Order.find_or_init_address(params[:order][:address_attributes]) if @user.cart.voucher
    @cart = @user.cart
    total_price = @cart.total_price
    if @order.payment_mode == 0
      wallet_processing @order, @user, total_price, @cart
    else
      # credit_card_processing @order, @user, total_price, @cart
    end
  end

  def wallet_processing(order, user, total_price, cart)
    availability, items_not_available = cart.items_available
    nxt_page = request.referrer
    if user.wallet < total_price
      flash[:error] = "Your wallet has insufficient money to pay."
    elsif availability
      if @order.save
        get_credit_transfer_lis(@order, user, cart, total_price)        
        flash[:notice] = "Your order has been placed"
        nxt_page = commodities_url
      else
        render :action => :new
        return true
      end
    else
      flash[:item_info] = generate_error_no_items(items_not_available)
      flash[:cart_flash] = true
    end
    redirect_to nxt_page
  end

  def get_credit_transfer_lis(order, user, cart, total_price)
    admin = User.main_admin[0]
    user.update_attribute(:wallet, user.wallet - total_price)
    admin.update_attribute(:wallet, admin.wallet + total_price)
    order.add_line_items_from_cart(cart)
  end

  def generate_error_no_items(items)
    str = items.join(', ')
    "Required quantity of #{str} is not available." 
  end

  def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end