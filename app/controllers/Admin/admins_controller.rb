class AdminsController < ApplicationController
  
  before_filter { |conroller| conroller.authorize(1) }

  def index
    respond_to do |format|
      format.html
    end
  end  
end