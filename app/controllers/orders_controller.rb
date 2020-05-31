class OrdersController <ApplicationController

  def new
    non_current_user?
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = current_user.orders.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      flash[:notice] = "Your order was created"
      redirect_to determine_path
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end


  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def non_current_user?
    if current_user.nil?
      redirect_to cart_path
    end
  end
  # This method will be updated for the merchant view of orders
  def determine_path
    if current_default_user?
      return default_user_profile_orders_path
    end
  end

end
