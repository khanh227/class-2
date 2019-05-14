module MenuHelper
  def user_can_edit_menu
    user_signed_in? && @menu.created_by == current_user.id
  end

  def menu_list
    Menu.pluck(:menu_date, :id)
  end
end
