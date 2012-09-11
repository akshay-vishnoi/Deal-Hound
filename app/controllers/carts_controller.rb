class CartsController < ApplicationController

  before_filter { |conroller| conroller.authorize(0) }
  
  def new
    
  end
end
