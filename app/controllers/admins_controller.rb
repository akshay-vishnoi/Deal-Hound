class AdminsController < ApplicationController
  
  before_filter { |conroller| conroller.authorize(true) }

  def index
    respond_to do |format|
      format.html
    end
  end  
end