class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  belongs_to :user, dependent: :destroy
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: {packaged: 0, pending: 1, shipped: 2, cancelled: 3}

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def grandtotal_for_merchant(current_user)
    x = current_user.merchant.id
    item_orders.joins(:item).where('items.merchant_id = ?', x).sum('item_orders.price * item_orders.quantity')
  end

  def total_quantity
    item_orders.sum(:quantity)
  end

  def cancel
    update(status: 3)

    item_orders.each do |item_order|
      item_order.update(status: 0)
      item_order.item.update(inventory: item_order.item.inventory + item_order.quantity)
    end
  end

  def items_subtotal(merchant_id)
    
  end

end
