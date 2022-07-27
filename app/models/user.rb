class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: {minimum: 4, maximum: 15}
  validates :standard_ids, presence: true
  has_many :user_students
  has_many :students, through: :user_students
  has_many :standard_users
  has_many :standards, through: :standard_users
end
