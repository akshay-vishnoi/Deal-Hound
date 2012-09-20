class Cart < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_many :commodity_skus
  has_many :line_items, :as => :item, :dependent => :destroy

  def add_item(commodity_sku_id, quantity)
    @commodity_sku = CommoditySku.find(commodity_sku_id)
    cart_lis = line_items.select('id')
    current_item = @commodity_sku.line_items.find_by_id(cart_lis)
    li_added_message =  "#{@commodity_sku.commodity.title} (#{@commodity_sku.color} #{@commodity_sku.size})"
    if current_item
        current_item.quantity = quantity
    else
      current_item = line_items.build()
      current_item.p_and_s = @commodity_sku
      current_item.price = @commodity_sku.commodity.selling_price
      current_item.quantity = quantity
    end
    li_added_message = "#{quantity} item(s) 0f " + li_added_message + " has/have been added.1"
    [current_item, li_added_message]
  end

  def items_available
    availability = true
    items_not_available = []
    line_items.each do |li|
      if li.quantity > li.p_and_s.quantity
        availability = false
        li.update_attribute(:quantity, li.p_and_s.quantity)
        items_not_available << li.name
      end
    end
    [availability, items_not_available]
  end
end
