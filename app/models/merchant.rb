class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items

  has_many :users

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  enum status: {enabled: 0, disabled: 1}

  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def inactivate_items
    items.each do |item|
      item.update(active?: false)
    end
  end

  def activate_items
    items.each do |item|
      item.update(active?: true)
    end
  end

  def self.find_by(params)
    merchant = Merchant.find(params)
  end

end
