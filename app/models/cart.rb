class Cart < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_many :commodity_skus
  has_many :line_items, :as => :item, :dependent => :destroy

  def add_item(p_and_s, quantity = 1)

    if p_and_s[:type] === "Voucher"
      @p_and_s = Voucher.find(p_and_s[:id])
      li_added_message =  "#{@p_and_s.commodity.title}"
    else
      @p_and_s = CommoditySku.find(p_and_s[:id])
      li_added_message =  "#{@p_and_s.commodity.title} (#{@p_and_s.color} #{@p_and_s.size})"
    end
    cart_lis = line_items.select('id')
    current_item = @p_and_s.line_items.find_by_id(cart_lis)    
    if current_item
        current_item.quantity = quantity
    else
      current_item = line_items.build()
      current_item.p_and_s = @p_and_s
      current_item.price = !@p_and_s.deal.blank? ? ((1 - (@p_and_s.deal.discount / 100)) * @p_and_s.selling_price) : @p_and_s.selling_price
      current_item.quantity = quantity
    end
    li_added_message = "#{@p_and_s.selling_price.class.to_s} item(s) 0f " + li_added_message + " has/have been added.1"
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
