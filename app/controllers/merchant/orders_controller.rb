class Merchant::OrdersController < Merchant::BaseController
  # def index
  #   @orders = find_orders
  # end

  def show
    @order = Order.find(params[:id])
    # @item_orders = current_user.merchant.items_from_order(order)
  end

  def update
    item_order = ItemOrder.find(params[:id])
    item = item_order.item
    item.update(inventory: (item.inventory - item_order.quantity))
    item_order.update(status: 1)
    redirect_to "/merchant/orders/#{item_order.order.id}"
    flash[:notice]= "You have fulfilled the item"
  end

  # private
  #
  # def find_orders
  #   @items = Item.where("merchant_id = #{current_user.merchant_id}")
  #   if !@items.nil?
  #     @item_orders = @items.each_with_object([]) do |item, arr|
  #       item = ItemOrder.where("#{item.id} = item_id")
  #       if !item.empty?
  #         arr << item
  #       end
  #     end.flatten
  #   end
  #   if !@item_orders.empty?
  #       @final_orders = @item_orders.map do |item_order|
  #       Order.find(item_order.order_id)
  #     end
  #   end
  #   @final_orders
  # end
end
