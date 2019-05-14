class Menu < ApplicationRecord
  belongs_to :user, foreign_key: 'created_by'

  def products
    Product.where(id: product_ids)    
  end
end
