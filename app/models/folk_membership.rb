class FolkMembership < ApplicationRecord
  belongs_to :user
  belongs_to :folk

  enum role: { member: 0, admin: 1 }
end
