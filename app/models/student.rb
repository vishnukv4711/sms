class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  validates :first_name,:last_name,:date_of_birth, presence: true
  validates :standard_id, presence: true
  validates :contact_number, length: { maximum: 12}
  has_many :user_students, dependent: :destroy
  has_many :users, through: :user_students
  has_many :academics, dependent: :destroy
  belongs_to :standard
end
