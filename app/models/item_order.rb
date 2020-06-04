class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity
  enum status: {cancelled: 0}
  belongs_to :item
  belongs_to :order

  enum status: %w(unfulfilled fulfilled)

  def subtotal
    price * quantity
  end

  #if item has inventory and its unfulfilled? display the fulfil button
  def can_be_fulfilled?
    has_inventory = (quantity <= item.inventory)
    # status == "unfulfilled"
    (has_inventory) && (status == "unfulfilled")
  end
end
