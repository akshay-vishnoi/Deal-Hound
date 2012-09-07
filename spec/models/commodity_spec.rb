require 'spec_helper'

describe Commodity do
  it "can be instantiated" do
    Commodity.new.should be_an_instance_of(Commodity)
  end
  it "can be saved" do
    Commodity.create(:title => "galaxy").should be_persisted
  end
end