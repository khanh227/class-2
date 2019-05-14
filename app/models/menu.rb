class Menu < ApplicationRecord
  has_many :product
  #scope :enabled, ->{ where(enabled: :true) }
  
  def products
    Product.where(id: product_ids)    
  end
end