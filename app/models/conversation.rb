class Conversation < ActiveRecord::Base
  acts_as_paranoid

  default_scope { order("updated_at DESC") }

  has_many :users, through: :conversations_users
  has_many :conversations_users
  has_many :chats

  def read_by!(user)
    user.conversations_users.find_by(conversation_id: id).update_column(:read_at, Time.now)
  end
end
