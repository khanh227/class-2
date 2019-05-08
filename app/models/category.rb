class Category < ApplicationRecord
	validates :name, presence: true, length: { minimum: 5 }
  has_many :products
end
