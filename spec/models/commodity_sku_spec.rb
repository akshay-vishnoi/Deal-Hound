require 'spec_helper'

module CommoditySkuSpecHelper
  
  def valid_commodity_attributes
    {
      :title => "Galaxy S3", 
      :voucher => 0, 
      :description => "Hey there", 
      :features => "hey there", 
      :vendor => "Samsung"
    }    
  end

  def valid_commodity_sku_attributes
    {
      :size => "Small", 
      :color => "Black", 
      :actual_price => 23.05, 
      :selling_price => 22.22
    }    
  end
end

describe CommoditySku do

  include CommoditySkuSpecHelper

  before do
    @category = Category.create(:name => "Mobiles")
    @commodity = Commodity.create(valid_commodity_attributes)
    @commodity.category = @category
    @commodity_sku = CommoditySku.new
    @commodity_sku.commodity = @commodity
    @commodity_sku.update_attributes(valid_commodity_sku_attributes)
  end
  
  it "can be instantiated" do
    @commodity_sku.should be_an_instance_of(CommoditySku)
  end
  
  it "can be saved" do
    @commodity_sku.should have(0).errors_on(:commodity_sku)
  end

  describe "validations" do
    
    context "quantity" do
      it "can be blank" do
        @commodity_sku.update_attribute(:quantity,  nil)
        @commodity_sku.should have(0).errors_on(:quantity)
      end

      it "should be numerical" do
        @commodity_sku.update_attribute(:quantity, "aas")
        @commodity_sku.should have(1).errors_on(:quantity)
        @commodity_sku.errors[:quantity].should eq(["Enter a valid quantity"])
      end

      it "should be integer" do
        @commodity_sku.update_attribute(:quantity, 12.5)
        @commodity_sku.should have(1).errors_on(:quantity)
        @commodity_sku.errors[:quantity].should eq(["Enter a valid quantity"])
      end

      it "should be greater than or equal to 0" do
        @commodity_sku.update_attribute(:quantity, -1)
        @commodity_sku.should have(1).errors_on(:quantity)
        @commodity_sku.errors[:quantity].should eq(["Enter a valid quantity"])
      end      
    end

    context "actual price" do
      
      it "can be blank" do
        @commodity_sku.update_attribute(:actual_price,  nil)
        @commodity_sku.should have(0).errors_on(:actual_price)
      end

      it "should be numerical" do
        @commodity_sku.update_attribute(:actual_price, "aas")
        @commodity_sku.should have(1).errors_on(:actual_price)
        @commodity_sku.errors[:actual_price].should eq(["Enter valid actual price"])
      end      

      it "should be greater than or equal to 0.01" do
        @commodity_sku.update_attribute(:actual_price, 0)
        @commodity_sku.should have(1).errors_on(:actual_price)
        @commodity_sku.errors[:actual_price].should eq(["Enter valid actual price"])
      end
    end

    context "selling_price" do
      
      it "can be blank" do
        @commodity_sku.update_attribute(:selling_price,  nil)
        @commodity_sku.should have(0).errors_on(:selling_price)
      end

      it "should be numerical" do
        @commodity_sku.update_attribute(:selling_price, "aas")
        @commodity_sku.should have(1).errors_on(:selling_price)
        @commodity_sku.errors[:selling_price].should eq(["Enter valid selling price"])
      end      

      it "should be greater than or equal to 0.01" do
        @commodity_sku.update_attribute(:selling_price, 0)
        @commodity_sku.should have(1).errors_on(:selling_price)
        @commodity_sku.errors[:selling_price].should eq(["Enter valid selling price"])
      end
    end

    context "size" do

      it "should be unique with combination of color and commodity id" do
        @commodity_sku1 = CommoditySku.create(valid_commodity_sku_attributes)
        @commodity_sku1.commodity = @commodity
        @commodity_sku1.should have(1).errors_on(:size)
        @commodity_sku1.errors[:size].should eq(["Size and Color already present."])
      end
    end
  end

  describe "Relationships" do

    context "Commodity" do

      before do
        @commodity = Commodity.create(valid_commodity_attributes)
        @commodity_sku.commodity = @commodity
      end

      it "should respond_to commodity" do
        @commodity_sku.should respond_to(:commodity)
        @commodity_sku.should have(0).error_on(:commodity)
      end

      it "belongs to one commodity" do
        @commodity_sku.commodity.should eq(@commodity)
      end
    end

    context "Line Items" do

      before do
        line_item1 = LineItem.create
        line_item1.p_and_s = @commodity_sku
        line_item2 = LineItem.create
        line_item2.p_and_s = @commodity_sku
      end

      it "should respond to line items" do
        @commodity_sku.should respond_to(:line_items)
        @commodity_sku.should have(0).errors_on(:line_items)
      end

      it "should have more than one line item" do
        @commodity_sku.should have(0).errors_on(:line_items)
      end

      it "should return line items" do
        @commodity_sku.line_items.should eq(LineItem.where('p_and_s_id = ? AND p_and_s_type = "CommoditySku"', @commodity_sku.id))
      end

      it "should destroy line items" do
        @commodity_sku.destroy
        LineItem.where('p_and_s_id = ? AND p_and_s_type = "CommoditySku"', @commodity_sku.id).should eq([])
      end
    end

    context "Deals" do

      before do
        Deal.any_instance.stub(:validate_date_with_others).and_return(true)
        Deal.any_instance.stub(:date_validation).and_return(true)
        deal1 = Deal.create
        deal1.p_and_s = @commodity_sku
        deal2 = Deal.create
        deal2.p_and_s = @commodity_sku
      end

      it "should respond to deals" do
        @commodity_sku.should respond_to(:deals)
        @commodity_sku.should have(0).errors_on(:deals)
      end

      it "should have more than one deals" do
        @commodity_sku.should have(0).errors_on(:deals)
      end

      it "should return deals" do
        @commodity_sku.deals.should eq(Deal.where('p_and_s_id = ? AND p_and_s_type = "CommoditySku"', @commodity_sku.id))
      end

      it "should destroy deals" do
        @commodity_sku.destroy
        Deal.where('p_and_s_id = ? AND p_and_s_type = "CommoditySku"', @commodity_sku.id).should eq([])
      end
    end
  end
end