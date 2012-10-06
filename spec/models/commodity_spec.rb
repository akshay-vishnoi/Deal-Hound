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
        vouchers = @commodity.vouchers
        @commodity.destroy
        Voucher.all.should_not include(vouchers)
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

      it "should return commodity_skus" do
        # @commodity.vouchers.should eq(CommoditySku.where('commodity_id = ?', @commodity.id))
      end

      it "should destroy vouchers" do
        # vouchers = @commodity.vouchers
        # @commodity.destroy
        # Voucher.all.should_not include(vouchers)
      end
    end
    # it { should have_many(:commodity_skus) }
    # it { should have_many(:images) }
    # it { should belongs_to(:category) }
  end

  describe "#new_launches" do

  end
end