class DefaultUser::CartController < DefaultUser::BaseController
  def show
    @items = cart.items
  end

end
