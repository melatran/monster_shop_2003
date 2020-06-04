class Merchant::OrdersController < Merchant::BaseController


  def show
    @order = Order.find(params[:id])
  end

  def update
    item_order = ItemOrder.find(params[:id])
    item = item_order.item
    item.update(inventory: (item.inventory - item_order.quantity))
    item_order.update(status: 1)
    redirect_to "/merchant/orders/#{item_order.order.id}"
    flash[:notice]= "You have fulfilled the item"
  end
end
