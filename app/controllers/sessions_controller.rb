class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      type_of_login(user)

      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
    else
      flash[:error] = "Invalid Credentials. Please Try Again"
      render :new
    end
  end

  private

  def type_of_login(user)
    if user.default?
      redirect_to '/default_user/profile'
    elsif user.merchant?
      redirect_to '/merchant/dashboard'
    elsif user.admin?
      redirect_to '/admin/dashboard'
    end
  end

end
