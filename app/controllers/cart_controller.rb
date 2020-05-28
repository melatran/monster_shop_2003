class CartController < ApplicationController
  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to items_path
  end

  def show
    @items = cart.items
    if current_admin?
      flash[:error] = "This page does not exist for you"
      redirect_to "/admin/dashboard"
    end    
  end

  def empty
    session.delete(:cart)
    redirect_to cart_path
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to cart_path
  end


end
