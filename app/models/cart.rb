class Cart < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_many :commodity_skus
  has_many :line_items, :as => :item, :dependent => :destroy

  def add_item(p_and_s, quantity = 1)

    if p_and_s[:type] === "Voucher"
      @p_and_s = Voucher.find(p_and_s[:id])
      li_added_message = "(#{@p_and_s.title})"
    else
      @p_and_s = CommoditySku.find(p_and_s[:id])
      li_added_message =  " (#{@p_and_s.color} #{@p_and_s.size})"
    end
    li_added_message =  "#{@p_and_s.commodity.title}" + li_added_message
    cart_lis = line_items.select('id')
    current_item = @p_and_s.line_items.where('deal_id is null').find_by_id(cart_lis)
    li_with_deal = @p_and_s.line_items.where('deal_id is not null').find_by_id(cart_lis)
    deal = @p_and_s.deals.where('visible = ?', true).first
    if current_item && !deal
      current_item.quantity = quantity
    elsif li_with_deal && deal
      deal = @p_and_s.deals.where('visible = ?', true).first
      if deal
        without_deal_quantity = quantity - deal.remaining_quantity
        current_item, li_with_deal = utility(without_deal_quantity, current_item, line_items, @p_and_s, li_with_deal)        
      end
    else
      deal = @p_and_s.deals.where('visible = ?', true).first
      if deal
        without_deal_quantity = quantity - deal.remaining_quantity
        li_with_deal = @p_and_s.line_items.build()
        li_with_deal.item = self
        li_with_deal.deal = deal
        current_item, li_with_deal = utility(without_deal_quantity, current_item, line_items, @p_and_s, li_with_deal)
        li_with_deal.price = (1-(deal.discount/100)) * @p_and_s.selling_price
      else
        current_item = line_items.build()
        current_item.p_and_s = @p_and_s
        current_item.price = @p_and_s.selling_price
        current_item.quantity = quantity
      end
    end
    li_added_message = "#{quantity} item(s) 0f " + li_added_message + " has/have been added.1"
    [current_item, li_with_deal, li_added_message]
  end

  def utility(without_deal_quantity, current_item, line_items, @p_and_s, li_with_deal)
    if without_deal_quantity > 0 
      if current_item
        current_item.quantity = without_deal_quantity
      else
        current_item = line_items.build()
        current_item.p_and_s = @p_and_s
        current_item.price = @p_and_s.selling_price
        current_item.quantity = without_deal_quantity
      end
      li_with_deal.quantity = deal.remaining_quantity
    else
      li_with_deal.quantity = quantity
    end
    return [current_item, li_with_deal]
  end

  def items_available
    availability = true
    items_not_available = []
    line_items.each do |li|
      if li.deal 
        if (!(li.deal.visible) || li.deal.remaining_quantity < li.quantity)
          availability = false
          li.destroy
          items_not_available << "#{li.p_and_s.commodity.title.to_s}(with -deal)"
        end
      elsif li.quantity > li.p_and_s.quantity
        availability = false
        li.update_attribute(:quantity, li.p_and_s.quantity)
        items_not_available << li.p_and_s.commodity.title
      end
    end
    [availability, items_not_available]
  end
end