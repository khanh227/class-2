module ProductHelper
  def user_can_edit_product
    if user_signed_in? && @product.user_id == current_user.id
      return true
    else
      return false
    end
  end
end
