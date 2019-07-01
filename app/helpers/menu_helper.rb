module MenuHelper
  def menu_list
    Menu.pluck(:menu_name, :id)
  end
end
