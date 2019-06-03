class MenusController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    @menu.save ? redirect_to(menus_path) : render('new')
  end

  def update
    @menu.update(menu_params) ? redirect_to(menus_path) : render('edit')
  end

  def destroy
    @menu.destroy
    redirect_to menus_path
  end

  private
    def menu_params
      params[:menu][:product_ids]&.reject!(&:blank?)&.map!(&:to_i)
<<<<<<< HEAD
<<<<<<< HEAD
      params.require(:menu).permit(:menu_name, :created_by, product_ids: [])
=======
      params.require(:menu).permit(:menu_name, :created_by, product_ids: [], :background_img)
>>>>>>> 8feaa8a... Issue-40: Create Background for Menu
=======
      params.require(:menu).permit(:menu_name, :background_img, :created_by, product_ids: [])
>>>>>>> 9610f4b... update code
    end
end
