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
        @category.should have(1).errors_on(:name)
        @category.errors[:name].should eq(["Category is already present"])
      end
    end
  end
end
