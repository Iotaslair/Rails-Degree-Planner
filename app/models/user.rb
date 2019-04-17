class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true  # Require a unique email
  validates :firstname, presence: true                # Require a first name
  validates :lastname, presence: true                 # Require a last name
end
