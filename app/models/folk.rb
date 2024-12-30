class Folk < ApplicationRecord
  has_many :folk_memberships
  has_many :users, through: :folk_memberships
  has_many :movements
end
