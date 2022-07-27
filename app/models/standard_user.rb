class StandardUser < ApplicationRecord
  belongs_to :user
  belongs_to :standard
end