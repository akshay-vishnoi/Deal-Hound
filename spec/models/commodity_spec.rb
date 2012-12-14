require 'spec_helper'

module CommoditySpecHelper
  def valid_commodity_attributes
    {
      :title => "Galaxy S3", 
      :voucher => 0, 
      :description => "Hey there", 
      :features => "hey there", 
      :vendor => "Samsung"
    }    
  end

  def valid_voucher_attributes
    {
      :title => "Testing voucher", 
      :redeem_within => "30", 
      :selling_price => 20, 
      :discount => 30
    }    
  end

  def valid_commodity_sku_attributes
    {
      :size => "Small", 
      :color => "Black"
    }    
  end
end

describe Commodity do

  include CommoditySpecHelper

  before do
    
    @category = Category.create(:name => "Mobiles")
    @commodity = Commodity.new
    @commodity.category = @category
    @commodity.update_attributes(valid_commodity_attributes)
  end
  
  it "can be instantiated" do
    @commodity.should be_an_instance_of(Commodity)
  end
  
  it "can be saved" do
    @commodity.should have(0).errors_on(:commodity)
  end

  describe "validations" do
  
    context "title" do 
      it "can't be blank" do
        @commodity.update_attribute(:title, "")
        @commodity.should have(1).errors_on(:title)
        @commodity.errors[:title].should eq(["can't be blank"])
      end

      it "should be unique" do
        @commodity1 = Commodity.create(valid_commodity_attributes)
        @commodity1.should have(1).errors_on(:title)
        @commodity1.errors[:title].should eq(["has already been taken"])
      end
    end
  end

  describe "Relationships" do
 
    context "vouchers" do

      before do
        @commodity.vouchers.create(valid_voucher_attributes)
        @commodity.vouchers.create(valid_voucher_attributes.with(:title => "Testing Voucher 2"))
      end
 
      it "should respond to vouchers" do
        @commodity.should respond_to(:vouchers)
        @commodity.should have(0).error_on(:vouchers)
      end

      it "should have more than one voucher" do
        @commodity.should have(0).errors_on(:vouchers)
      end

      it "should return vouchers" do
        @commodity.vouchers.should eq(Voucher.where('commodity_id = ?', @commodity.id))
      end

      it "should destroy vouchers" do
        @commodity.destroy
        Voucher.where('commodity_id', @commodity.id).should eq([])
      end
    end
    
    context "commodity skus" do
      
      before do
        @commodity.commodity_skus.create(valid_commodity_sku_attributes)
        @commodity.commodity_skus.create(valid_commodity_sku_attributes.with(:size => "Medium"))
      end

      it "should respond to commodity skus" do
        @commodity.should respond_to(:commodity_skus)
        @commodity.should have(0).errors_on(:commodity_skus)
      end

      it "should have more than one commodity sku" do
        @commodity.should have(0).errors_on(:commodity_skus)
      end

      it "should return commodity skus" do
        @commodity.commodity_skus.should eq(CommoditySku.where('commodity_id = ?', @commodity.id))
      end

      it "should destroy commodity skus" do
        @commodity.destroy
        CommoditySku.where('commodity_id', @commodity.id).should eq([])
      end
    end

    context "Images" do
      
      before do
        image1 = Image.create
        image1.snapshot = @commodity
        image2 = Image.create
        image2.snapshot = @commodity
      end

      it "should respond to images" do
        @commodity.should respond_to(:images)
        @commodity.should have(0).errors_on(:images)
      end

      it "should have more than one image" do
        @commodity.should have(0).errors_on(:commodity_skus)
      end

      it "should return images" do
        @commodity.images.should eq(Image.where('snapshot_id = ? AND snapshot_type = "Commodity"', @commodity.id))
      end

      it "should destroy commodity skus" do
        @commodity.destroy
        Image.where('snapshot_id = ? AND snapshot_type = "Commodity"', @commodity.id).should eq([])
      end
    end

    context "Category" do

      it "should respond_to category" do
        @commodity.should respond_to(:category)
        @commodity.should have(0).error_on(:category)
      end

      it "belongs to one category" do
        @commodity.category.should eq(@category)
      end
    end
  end

  describe "Class methods" do

    context "new_launches" do
      
    end
  end
end