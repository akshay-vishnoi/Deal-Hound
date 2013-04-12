class OrdersController < ApplicationController

  before_filter() { |controller| controller.authorize(session[:admin])}
  before_filter :load_user
  before_filter :load_cart, :only => [:new, :create]
  before_filter :load_order, :only => [:edit, :update]

  helper_method :sort_column, :sort_direction
  def new
    @order = @user.orders.new(:mailing_email => @user.email, :full_name => @user.name)
    @order.address = Address.new if @user.cart.voucher
  end

  def edit
  end

  def update
    if @order.update_attributes(:status => params[:order][:status])
      flash[:notice] = "Now Order no. #{@order.id} is #{@order.status_to_s}."
    else
      flash[:error] = "Error while saving order. Please check it again."
    end
    redirect_to orders_url
  end

  def index
    find_by_attr = @user.admin? ? params[:search] : session[:user_id]
    @orders = Order.search(find_by_attr, sort_column, sort_direction, params[:page], @user.admin?)
  end

  def create
    @order = @user.orders.new(params[:order])
    @order.address = Order.find_or_init_address(params[:order][:address_attributes]) if @user.cart.voucher
    total_price = @cart.total_price
    if @order.payment_mode == 0
      wallet_processing @order, @user, total_price, @cart
    else
      # credit_card_processing @order, @user, total_price, @cart
    end
  end

  private

  def load_user
    @user = User.where(id: session[:user_id]).first
    unless @user
      flash[:error] = "Please login."
      redirect_to(root_path) && return
    end
  end

  def load_cart
    @cart = @user.cart
    unless @cart.line_items.present?
      flash[:error] = "There is no item in cart"
      redirect_to(commodities_url) && return
    end
  end

  def load_order
    @order = Order.where(id: params[:id]).first
    unless @order
      flash[:error] = "No such order exists"
      redirect_to(orders_path) && return
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