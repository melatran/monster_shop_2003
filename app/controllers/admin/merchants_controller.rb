class Admin::MerchantsController < Admin::BaseController

    def index
      @merchants = Merchant.all
    end

    def show
        @merchant = Merchant.find(params[:id])
    end

    def update
      merchant = Merchant.find(params[:id])
      merchant.update(status: 1)
      merchant.inactivate_items

      redirect_to "/admin/merchants"
      flash[:notice] = "#{merchant.name} has been disabled"
    end
end
