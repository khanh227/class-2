class Menu < ApplicationRecord
  belongs_to :user, foreign_key: 'created_by'

  scope :by_name, ->(menu_name) { where(menu_name: menu_name) }

  def products
    Product.where(id: product_ids)    
  end
end
