class Merchant::OrdersController < Merchant::BaseController
  def show
    @orders = find_orders
  end

  private

  def find_orders
    @items = Item.where("merchant_id = #{current_user.merchant_id}")
    if !@items.nil?
      @item_orders = @items.each_with_object([]) do |item, arr|
        item = ItemOrder.where("#{item.id} = item_id")
        if !item.empty?
          arr << item
        end
      end.flatten
    end
    if !@item_orders.empty?
        @final_orders = @item_orders.map do |item_order|
        Order.find(item_order.order_id)
      end
    end
    @final_orders
  end

  # def find_items
  #   Item.where("merchant_id = #{current_user.merchant_id}")
  # end
  #
  # def find_item_orders
  #   if find_items.empty?
  #     find_items.each_with_object([]) do |item, arr|
  #       item = ItemOrder.where("#{item.id} = item_id")
  #       if !item.empty?
  #         arr << item
  #       end
  #     end.flatten
  #   end
  # end
  #
  # def find_ordersz
  #   if !find_item_orders.nil?
  #     find_item_orders.map do |item_order|
  #       Order.find(item_order.order_id)
  #     end
  #   end
  # end
end
