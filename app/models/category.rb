class Category < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true, length: { minimum: 5 }
  has_many :products
end
