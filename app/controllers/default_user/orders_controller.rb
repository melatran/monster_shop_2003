class DefaultUser::OrdersController < DefaultUser::BaseController

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.cancel
    flash[:notice] = "Your Order Has Been Cancelled"
    redirect_to default_user_profile_path
  end

end
