class DefaultUser::ProfileController < DefaultUser::BaseController

    def index
    end

    def edit
      if params[:pw] == "change"
        @var = 1
      end
    end

    def update
      if password_change?
        flash[:error] = "Password and confirmation password need to match"
        redirect_to "/default_user/profile/edit?pw=change"
        return
      end
      current_user.update(user_params)
      if current_user.save
        if params[:pw] == "changed"
          flash[:notice] = "Your password has been updated"
        else
          flash[:notice] = "Your data was updated"
        end
        redirect_to default_user_profile_path
      else     
        flash[:error] = current_user.errors.full_messages.to_sentence
        redirect_to "/default_user/profile/edit"
      end
    end


    private

    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
    end

    def password_change?
        params[:password] != params[:password_confirmation]      
    end
end
