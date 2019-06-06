module MenuHelper
  def menu_list
    Menu.pluck(:menu_name, :id)
  end

  def display_background_img(menu)
    if menu.background_img.attached?
      result = url_for(menu.background_img)
    else
      result = ''
    end
    result
  end
end
