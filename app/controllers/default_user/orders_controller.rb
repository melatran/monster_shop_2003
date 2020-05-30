class DefaultUser::OrdersController < DefaultUser::BaseController

  def index
    @orders = current_user.orders
  end
end
