class Admin::DashboardController < Admin::BaseController
    
    before_action :require_admin

    def index
    end 

end