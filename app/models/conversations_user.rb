class ConversationsUser < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :conversation
  belongs_to :user
end
