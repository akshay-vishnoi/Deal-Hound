require 'spec_helper'

module AddressSpecHelper
  def valid_address_attributes
    {
      :pincode => 110007, 
      :city => "Delhi", 
      :state => "Delhi", 
      :street => "Kamla nagar"
    }    
  end
end

describe Address do
  
  include AddressSpecHelper

  before do
    @address = Address.create(valid_address_attributes)
  end
  it "can be instantiated" do
    @address.should be_an_instance_of(Address)
  end
  
  it "can be saved" do
    @address.should have(0).errors_on(:address)
  end

  describe "validations" do

    it "should have city" do
      @address.update_attribute(:city, "")
      @address.should have(1).errors_on(:city)
      @address.errors[:city].should eq(["can't be blank"])
    end

    it "should have state" do
      @address.update_attribute(:state, "")
      @address.should have(1).errors_on(:state)
      @address.errors[:state].should eq(["can't be blank"])
    end

    it "should have street" do
      @address.update_attribute(:street, "")
      @address.should have(1).errors_on(:street)
      @address.errors[:street].should eq(["can't be blank"])
    end

    it "should have numeric pincode" do
      @address.update_attribute(:pincode, "")
      @address.should have(1).errors_on(:pincode)
      @address.errors[:pincode].should eq(["is not a number"])
    end
  end

  describe "associations" do

    before do
      # @order = mock_model(Order)

      # @order1 = mock_model(Order)

    end
    
    it "should respond to order" do
      @address.should respond_to(:orders)
      @address.should have(0).error_on(:orders)
    end

    it "should have many orders" do
      # @address.orders = [@order, @order1]
      # @address.orders = @order1
      # @address.order.should eq(@order)
    end
  end
end
