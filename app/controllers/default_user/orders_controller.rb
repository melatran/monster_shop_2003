class DefaultUser::OrdersController < DefaultUser::BaseController

  def index
    @orders = active_orders
  end

  def show
    @order = Order.find(params[:order_id])
  end

  def update
    order = Order.find(params[:id])
    order.cancel
    flash[:notice] = "Your Order Has Been Cancelled"
    redirect_to default_user_profile_path
  end

  private

  def active_orders
    current_user.orders.each_with_object([]) do |order,arr|
      if order.status != "cancelled"
        arr << order
      end
    end
  end

end
