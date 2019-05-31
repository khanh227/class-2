module MenuHelper
  def menu_list
    Menu.pluck(:menu_date, :id)
  end
end
