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
        category_id = @category.id
        @category.destroy
        Commodity.where('category_id = ?', category_id).should eq([])
      end
    end
  end

  describe "Scopes" do

    context "delete_multiple" do

      before do
        @category1 = Category.create(:name => "Health and care")
        @category2 = Category.create(:name => "Spa")
      end

      it "should delete selected categories" do
        Category.delete_multiple([@category1, @category2])
        Category.find_all_by_id([@category1.id, @category2.id]).should eq([])
      end
    end
  end

  describe "Class Methods" do

    before do
      @category1 = Category.create(:name => "Health and care")
      @category2 = Category.create(:name => "Spa")
    end

    context "sort_cat" do
      it "should return sorted categories" do 
        Category.sort_cat.should eq([@category1, @category, @category2])
      end
    end

    context "all_errors" do

      it "should return errors on categories" do
        @category.name = "Health and care"
        @category.save
        @category.all_errors.should eq("Category is already present")
      end
    end
  end
end