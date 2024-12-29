module Posts
  class Share < ApplicationRecord
    belongs_to :user
    belongs_to :post
  end
end
