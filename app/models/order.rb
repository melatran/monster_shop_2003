class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: {packaged: 0, pending: 1, shipped: 2, cancelled: 3}

  def grandtotal
    item_orders.sum('price * quantity')
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
end
