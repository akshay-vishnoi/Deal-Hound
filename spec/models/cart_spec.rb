require 'spec_helper'

describe Cart do
  
  before do
    @cart = Cart.create
  end

  it "can be instantiated" do
    @cart.should be_an_instance_of(Cart)
  end
  
  it "can be saved" do
    @cart.should have(0).errors_on(:cart)
  end

  describe "Relationships" do

    context "Users" do

      before do
        @user = mock_model(User)
        @cart.user = @user
      end

      it "should respond_to users" do
        @cart.should respond_to(:user)
        @cart.should have(0).error_on(:user)
      end

      it "belongs to one user" do
        @cart.user.should eq(@user)
      end
    end

    context "Line Items" do

      before do
        @line_item1 = LineItem.create
        @line_item2 = LineItem.create
        @cart.line_items = [@line_item1, @line_item2]
      end

      it "should respond_to line items" do 
        @cart.should respond_to(:line_items)
        @cart.should have(0).errors_on(:line_items)
      end

      it "should have more than one line items" do
        @cart.should have(0).errors_on(:line_items)
      end

      it "should return line_items" do
        @cart.line_items.should eq(LineItem.where('item_id = ? AND item_type = "Cart"', @cart.id))
      end

      it "should destroy vouchers" do
        @cart.destroy
        LineItem.where('item_id = ? AND item_type = "Cart"', @cart.id).should eq([])
      end
    end
  end

  describe "Methods" do

    describe "items_available" do

      before do
        availability = true
        items_not_available = []
      end
            

    end
  end
end


# def items_available
#     availability = true
#     items_not_available = []
#     line_items.each do |li|
#       if li.deal 
#         if (!(li.deal.visible) || li.deal.remaining_quantity < li.quantity)
#           availability = false
#           li.destroy
#           items_not_available << "#{li.p_and_s.commodity.title.to_s}(with -deal)"
#         end
#       elsif li.quantity > li.p_and_s.quantity
#         availability = false
#         li.update_attribute(:quantity, li.p_and_s.quantity)
#         items_not_available << li.p_and_s.commodity.title
#       end
#     end
#     [availability, items_not_available]
#   end