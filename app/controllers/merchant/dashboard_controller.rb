class Merchant::DashboardController < Merchant::BaseController

  def index
    @user = current_user
    @orders = Order.where('orders.status = 1').joins(:items).where('items.merchant_id = ?', @user.merchant.id).distinct
  
  end

end
