require 'test_helper'

class CommodityTest < ActiveSupport::TestCase
  
  fixtures :commodities

  test "commodity title must not be empty" do
    product = Commodity.new
    assert product.invalid?
    assert product.errors[:title].any?
  end

  test "commodity actual and selling price must be greater than zero" do
    product = Commodity.new(:title => "Iphone")
    product.actual_price = -1
    product.selling_price = -1
    assert product.invalid?
    assert_equal "must be a valid price", product.errors.get(:actual_price).join(', ')
    assert_equal "must be a valid price", product.errors.get(:selling_price).join(', ')
  end
end
