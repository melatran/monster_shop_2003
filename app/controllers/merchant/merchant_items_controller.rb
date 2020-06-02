class Merchant::MerchantItemsController < Merchant::BaseController

    def index
        @user = current_user
    end

    def update
      item = Item.find(params[:id])

      if item.active? == true
        item.update(active?:false)
        flash[:notice] = "#{item.name} is no longer for sale"
      else
        item.update(active?:true)
        flash[:notice] = "#{item.name} is now available for sale"
      end
      redirect_to "/merchant/items"
    end
end
