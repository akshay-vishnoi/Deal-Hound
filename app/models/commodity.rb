class Commodity < ActiveRecord::Base

  attr_accessible :title, :features, :description, :delivery_type, :vendor, :voucher, :images_attributes, :commodity_skus_attributes
  TYPE = { "Product" => 0, "Service" => 1 }

  #Validation
  validates :title, :presence => true, 
                    :uniqueness => true
  
  #Category Association
  belongs_to :category

  #Vouchers Association
  has_many :vouchers, :dependent => :delete_all, :inverse_of => :commodity
  
  #CommoditySku Association
  has_many :commodity_skus, :dependent => :delete_all, :inverse_of => :commodity
  accepts_nested_attributes_for :commodity_skus, :reject_if => lambda { |t| t['size'].empty? && t['color'].empty? && t['quantity'].empty? && t['selling_price'].empty? && t['actual_price'].empty?}

  #Images Association
  has_many :images, :as => :snapshot, :dependent => :destroy
  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['photo'].nil?}

  def self.search(params)
    if params[:search]
      where('title LIKE ?', "%#{params[:search]}%").paginate_commodity(params[:page])
    else
      scoped.paginate_commodity(params[:page])
    end
  end

  def self.new_launches(params)
    where(:created_at => (1.days.ago.to_time)..(Time.now)).paginate_commodity(params[:page])
  end

  def self.paginate_commodity(page)
    paginate page: page, per_page: 3
  end
end