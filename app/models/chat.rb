class Chat < ActiveRecord::Base
  scope :global, ->{ where("conversation_id IS NULL") }

  belongs_to :user
  belongs_to :conversation

  validates :message, presence: true

  def to_s
    message
  end
end
