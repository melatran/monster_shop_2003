class Merchant::MerchantItemsController < Merchant::BaseController
  def index
    @user = current_user
  end

  def update
    item = Item.find(params[:id])
    #I was thinking an if else statement when it comes to updating items (status vs editing)
    change_item_status
    redirect_to "/merchant/items"
  end

  private

  def change_item_status
    item = Item.find(params[:id])
    if item.active? == true
      item.update(active?:false)
      flash[:notice] = "#{item.name} is no longer for sale"
    else
      item.update(active?:true)
      flash[:notice] = "#{item.name} is now available for sale"
    end
  end
end
