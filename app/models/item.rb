class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders, dependent: :destroy
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.popularity(direction)
      joins(:item_orders).select("items.*, sum(item_orders.quantity) as total_quantity").group(:id).order("total_quantity #{direction}").limit(5)
  end
  
  def total_in_order(odr_id, itm_id) 
    ItemOrder.where('item_id = ?', itm_id).where('order_id = ?', odr_id).first.quantity
  end

  def subtotal_item(odr_id, itm_id)
    item = Item.find(itm_id)
    total_in_order(odr_id, itm_id) * item.price
  end 

  def never_sold?(id)
   Item.where('items.id = ?', id).joins(:item_orders).where('item_orders.item_id = ?', id).count == 0    
  end 
end
