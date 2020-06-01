class DefaultUser::OrdersController < DefaultUser::BaseController

  def index
    @orders = active_orders
  end

  def show
    @order = Order.find(params[:order_id])
  end

  def update
    order = Order.find(params[:order_id])
    order.items.each do |item,quantity|
      order.item_order.update({
        quantity: 0,
        price: 0,
        status: 0
        })
    end
    order.update({
      status: 3
      })
    flash[:notice] = "Your order is now cancelled"
    redirect_to "/default_user/profile"
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
