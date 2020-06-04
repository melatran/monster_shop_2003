class Merchant::DashboardController < Merchant::BaseController

  def index
    @user = current_user 
    @orders = Order.where('orders.status = 1').joins(:items).where('items.merchant_id = ?', @user.merchant.id).distinct
    # total_for_merchant_items(@orders)
  end 
  
  
  private
  
  # def total_for_merchant_items(orders)
  #   acc = 0
    
  #   orders.each do |order|
      
  #     x = ItemOrder.select(:price, :quantity).where(‘order_id = 9’).joins(:item).where(‘item.merchant_id = 15’)
  #     x.each do |y|
  #       acc += y.price * y.quantity
        

  #     end 
  #   end
    
  # end
end
