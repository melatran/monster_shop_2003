class SessionsController < ApplicationController
  def new
    if !session[:user_id].nil?
      find_and_redirect(session[:user_id])
      flash[:notice] = "You are already logged in"
    end
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

  def destroy
    reset_session
    flash[:notice] = "You have been logged out"
    redirect_to root_path
  end

  private

  def type_of_login(user)
    if user.default?
      redirect_to default_user_profile_path
    elsif user.merchant?
      redirect_to merchant_dashboard_path
    elsif user.admin?
      redirect_to admin_dashboard_path
    end
  end

  def find_and_redirect(id)
    user = User.find_by(id: id)
    if user.default?
      redirect_to '/default_user/profile'
    elsif user.merchant?
      redirect_to '/merchant/dashboard'
    elsif user.admin?
      redirect_to '/admin/dashboard'
    end
  end

end
