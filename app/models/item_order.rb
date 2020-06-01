class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity
  enum status: {cancelled: 0}
  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end
end
