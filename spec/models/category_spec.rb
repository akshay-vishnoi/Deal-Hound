require 'spec_helper'

describe "Commodity" do

  before do

    @category = Category.create(:name => "Mobiles")
  end

  it "can be instantiated" do
    @category.should be_an_instance_of(Category)
  end
  
  it "can be saved" do
    @category.should have(0).errors_on(:category)
  end

  describe "Validations" do

    context "name" do
      
      it "can't be blank" do
        @category.update_attribute(:name, "")
        @category.should have(1).errors_on(:name)
        @category.errors[:name].should eq(["Category can't be blank"])
      end

      it "should be unique" do
        @category1 = Category.create(:name => "mObIlEs")
        @category1.should have(1).errors_on(:name)
        @category1.errors[:name].should eq(["Category is already present"])
      end
    end
  end

  describe "Relationships" do

    context "Commodities" do

      before do
        @commodity1 = Commodity.create(:title => "Galaxy")
        @commodity2 = Commodity.create(:title => "iAndi")
        @category.commodities = [@commodity1, @commodity2]
      end

      it "should respond_to commodities" do 
        @category.should respond_to(:commodities)
        @category.should have(0).errors_on(:commodities)
      end

      it "should have more than one commodities" do
        @category.should have(0).errors_on(:commodities)
      end

      it "should return commodities" do
        @category.commodities.should eq(Commodity.where('category_id = ?', @category.id))
      end

      it "should destroy commodities" do
        @category.destroy
        Commodity.where('category_id = ?', @category.id).should eq([])
      end
    end
  end

  describe "Scopes" do

    context "delete_multiple" do

      it
    end
  end
end