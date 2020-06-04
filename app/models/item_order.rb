class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity
  enum status: {cancelled: 0}
  belongs_to :item
  belongs_to :order

  enum status: %w(unfulfilled fulfilled)

  def subtotal
    price * quantity
  end


  def total_price(item_order_array)
    item_order_array.sum do |item_order|
      item_order.price * item_order.quantity
    end
  end 

  #if item has inventory and its unfulfilled? display the fulfil button
  def can_be_fulfilled?
    has_inventory = (quantity <= item.inventory)
    # status == "unfulfilled"
    (has_inventory) && (status == "unfulfilled")
  end

end
