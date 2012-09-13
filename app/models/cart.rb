class Cart < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_many :commodity_skus
  has_many :line_items, :dependent => :destroy

  def add_item(commodity_sku_id, quantity)
    @commodity_sku = CommoditySku.find(commodity_sku_id)
    current_item = line_items.find_by_commodity_sku_id(commodity_sku_id)
    li_added_message =  "#{@commodity_sku.commodity.title} (#{@commodity_sku.color} #{@commodity_sku.size})"
    if current_item
        current_item.quantity = quantity
    else
      current_item = line_items.build(commodity_sku_id: commodity_sku_id)
      current_item.price = @commodity_sku.commodity.selling_price
      current_item.quantity = quantity
    end
    li_added_message = "#{quantity} item(s) 0f " + li_added_message + " has/have been added.1"
    [current_item, li_added_message]
  end
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
