module ApplicationHelper
  def check_user_signed_in
    if user_signed_in && @product.user_id == current_user.id
      return true
    else
      return false
    end
  end
end
