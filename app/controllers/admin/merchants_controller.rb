class Admin::MerchantsController < Admin::BaseController


  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(parmas[:id])
    if merchant.status == "disabled"
      enable_merchant
      flash[:notice] = "#{merchant.name} is now enabled."
    else
      merchant.update(status: 1)
      merchant.inactivate_items
      flash[:notice] = "#{merchant.name} has been disabled"
    end
    redirect_to "/admin/merchants"
  end

  def show
      @merchant = Merchant.find(params[:id])
  end

  private
  def enable_merchant
    merchant = Merchant.find(params[:id])
    merchant.update(status: 0)
    items = Item.where("merchant_id = #{merchant.id}")
    items.each do |item|
      item.update(active?: true)
    end
  end
end
