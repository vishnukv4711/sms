class Standard < ApplicationRecord
  has_many :students
  has_many :standard_users
  has_many :users, through: :standard_users
end