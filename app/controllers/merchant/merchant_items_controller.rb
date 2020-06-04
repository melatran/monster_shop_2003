class Merchant::MerchantItemsController < Merchant::BaseController

    def index
        @user = current_user  
    end

    def new
        @merchant = current_user
    end

    def create
        item = Item.new(merchant_item_params)
        item.merchant_id = current_user.merchant_id
        if item.save
            flash[:success] = "#{item.name} has been added to list of items"
            redirect_to "/merchant/items"
        else
            flash[:error] = "All fields must me completed"
            render :new
        end
    end

    def destroy        
        item = Item.find(params[:id])
        item.delete
        flash[:notice] = "#{item.name} has been deleted"
        redirect_to "/merchant/items"
    end 

    private

    def merchant_item_params
        params.permit(:name, :description, :image, :price, :inventory, :active?)
    end 
end 