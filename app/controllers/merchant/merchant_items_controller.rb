class Merchant::MerchantItemsController < Merchant::BaseController

    def index
        @user = current_user  
    end
end 