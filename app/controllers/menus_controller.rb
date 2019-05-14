class MenusController < ApplicationController
  def index
    @menus = Menu.all
  end

  def show
    menu
  end

  def new
    @menu = Menu.new
  end

  def edit
    menu
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.save ? redirect_to(menus_path) : render('new')
  end

  def update
    menu.update(menu_params) ? redirect_to(menus_path) : render('edit')
  end

  def destroy
    menu.destroy
    redirect_to menus_path
  end

  private
    def menu
      @menu ||= Menu.find(params[:id])
    end

    def menu_params
      params[:menu][:product_ids]&.reject!(&:blank?)&.map!(&:to_i)
      params.require(:menu).permit(:menu_date, :created_by, product_ids: [])
    end
end
