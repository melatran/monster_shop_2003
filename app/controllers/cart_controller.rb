class CartController < ApplicationController
  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    if params[:do] == "one_more"
      flash[:success] = "You've added one more #{item.name} to your cart"
      redirect_to "/cart"
    else
      flash[:success] = "#{item.name} was successfully added to your cart"
      redirect_to items_path
    end
  end

  def show
    non_current_user?
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
    if params[:do] == "one_less"
      item = Item.find(params[:item_id])
      cart.contents[params[:item_id]] -= 1
      if cart.contents[params[:item_id]] == 0
        session[:cart].delete(params[:item_id])
      end
      flash[:success] = "You've removed one #{item.name} from your cart"
    else
    session[:cart].delete(params[:item_id])
    end
    redirect_to cart_path
  end

  private

  def non_current_user?
    if current_user.nil?
      flash.now[:notice] = "You must #{helpers.link_to "Register", register_path} or #{helpers.link_to "Login", login_path} to continue".html_safe
    end
  end

end
