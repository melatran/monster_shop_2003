class UserController < ApplicationController
  def index
  end

  def create
    binding.pry
    user = User.new(user_params)
    if user.save
      flash[:notice] = "You are now registered and logged in"
      redirect_to "/profile"
    else
      render :new
    end
  end

  def new

  end
  private

  def user_params
    params.permit(:name, :city, :state, :zip, :email, :password)
  end
end
