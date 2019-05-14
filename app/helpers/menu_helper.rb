module MenuHelper
  def user_can_edit_menu
    user_signed_in? && @menu.user_id == current_user.id
  end

  def menu_list
    Menu.pluck(:menu_date, :id)
  end
end
