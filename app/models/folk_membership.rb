class FolkMembership < ApplicationRecord
  belongs_to :user
  belongs_to :folk

  enum :role, {:member=>0, :admin=>1}

  after_create :add_user_to_group_chat

  private

  def add_user_to_group_chat
    if folk.chat.present? && !folk.chat.users.include?(user)
      ChatUser.create(user: user, chat: folk.chat)
    end
  end
end
