class AdminsController < ApplicationController
  before_filter { |conroller| conroller.authorize("admin") }
  def index
    respond_to do |format|
      format.html
    end
  end
end
