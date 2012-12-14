require 'spec_helper'

module DealSpecHelper
  def valid_deal_attributes
    {
      :discount => 10, 
      :max_quantity => 10, 
      :city => "Delhi", 
      :start_date => "2012-10-06", 
      :end_date => "2012-11-06", 
      :remaining_quantity => 10
    }    
  end
end

describe Deal do
  
  include DealSpecHelper

  before do
    @commodity_sku = CommoditySku.create(:size => "Medium")
    @deal = Deal.new(valid_deal_attributes)
    @deal.p_and_s = @commodity_sku
    @deal.save
  end

  it "can be instantiated" do
    @deal.should be_an_instance_of(Deal)
  end
  
  it "can be saved" do
    @deal.should have(0).errors_on(:deal)
  end

  describe "Validations" do

    context "Discount" do

      it "should have numeric discount" do
        @deal.update_attribute(:discount, "")
        @deal.should have(1).errors_on(:discount)
        @deal.errors[:discount].should eq(["is not a number"])
      end
    end

    context "max quantity" do

      it "should be numerical" do
        @deal.update_attribute(:max_quantity, "aas")
        @deal.should have(1).errors_on(:max_quantity)
        @deal.errors[:max_quantity].should eq(["Enter a valid quantity"])
      end

      it "should be integer" do
        @deal.update_attribute(:max_quantity, 12.5)
        @deal.should have(1).errors_on(:max_quantity)
        @deal.errors[:max_quantity].should eq(["Enter a valid quantity"])
      end

      it "should be greater than or equal to 0" do
        @deal.update_attribute(:max_quantity, -1)
        @deal.should have(1).errors_on(:max_quantity)
        @deal.errors[:max_quantity].should eq(["Enter a valid quantity"])
      end      
    end

    context "start date" do

      it "can't be blank" do
        @deal.update_attribute(:start_date, "")
        @deal.should have(1).errors_on(:start_date)
        @deal.errors.messages[:start_date].should eq(["Start date can't be blank."])
      end

      it "must be before end date" do
        @deal.update_attribute(:start_date, "2012-12-06")
        @deal.should have(1).errors_on(:start_date)
        @deal.errors.messages[:start_date].should eq(["must be before 2012-11-06"])
      end
    end

    context "end date" do

      it "can't be blank" do
        @deal.update_attribute(:end_date, "")
        @deal.should have(1).errors_on(:end_date)
        @deal.errors.messages[:end_date].should eq(["End date can't be blank."])
      end

      it "must be after start date" do
        @deal.update_attribute(:end_date, "2012-10-03")
        @deal.should have(1).errors_on(:end_date)
        @deal.errors.messages[:end_date].should eq(["must be after 2012-10-03"])
      end
    end
    
  end
end
