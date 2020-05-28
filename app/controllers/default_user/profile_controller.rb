class DefaultUser::ProfileController < DefaultUser::BaseController

    def index
    end

    def edit
    end

    def update
      current_user.update(user_params)
      if current_user.save
        flash[:notice] = "Your data was updated"
        redirect_to default_user_profile_path
      else
        flash[:error] = current_user.errors.full_messages.to_sentence
        redirect_to "/default_user/profile/edit"
      end
    end


    private

    def user_params
        params.permit(:name, :address, :city, :state, :zip, :email)
    end
end
