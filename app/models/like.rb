class Like < ApplicationRecord
  belongs_to :user
  belongs_to :movement, optional: true
  belongs_to :vibe, optional: true
end
