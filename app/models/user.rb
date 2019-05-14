class User < ApplicationRecord
  acts_as_paranoid

  has_many :products

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role_user: [:customer, :restaurant, :admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
