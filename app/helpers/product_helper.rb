module ProductHelper
  def user_can_edit_product
    user_signed_in? && @product.user_id == current_user.id
  end

  def category_list
    Category.all
  end
end
