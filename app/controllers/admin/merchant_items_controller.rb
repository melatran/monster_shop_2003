class Admin::MerchantItemsController < Admin::BaseController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    if item.active? == true
      item.update(active?:false)
      flash[:notice] = "#{item.name} is no longer for sale"
    else
      item.update(active?:true)
      flash[:notice] = "#{item.name} is now available for sale"
    end
    redirect_to "/admin/merchants/#{merchant.id}/items"
  end
end
