class SubscriptionsController < ApplicationController
  
  def subscription
    @subscribe = Subscribe.new(:email => params[:email])
    if @subscribe.save
      flash[:notice] = "#{params[:email]} has been subscribed."
    else
      flash[:error] = @subscribe.errors.get(:email).first
    end
    redirect_to request.referrer
  end

  def unsubscribe
    @subscribe = Subscribe.find_by_email(params[:email])
    if @subscribe
      @subscribe.delete 
      flash[:notice] = "Successfully unsubscribed."
    else
      flash[:error] = "Invalid Request"
    end
    redirect_to commodities_url
  end
end