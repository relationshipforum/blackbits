class Conversation < ActiveRecord::Base
  has_many :users, through: :conversations_users
  has_many :conversations_users
  has_many :chats
end
