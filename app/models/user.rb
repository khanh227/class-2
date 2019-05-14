class User < ApplicationRecord
  acts_as_paranoid

  has_many :products
  has_many :menus, foreign_key: 'created_by'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
