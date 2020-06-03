class Admin::AdminMerchantItemsController < Admin::BaseController

    def edit
      @item = Item.find(params[:item_id])
      @merchant = Merchant.find(@item.merchant_id)
    end

    def update
      @item = Item.find(params[:item])
      @item.update(item_params)
      updateable?
    end

    private

    def item_params
      params.permit(:name, :description, :price, :image, :inventory)
    end

    def updateable?
      if @item.save
        flash[:notice] = "#{@item.name} has been updated"
        redirect_to "/admin/merchants/#{@item.merchant_id}/items"
      else
        flash[:error] = @item.errors.full_messages.to_sentence
        redirect_to "/admin/merchant/items/#{@item.id}"
      end
    end
end
