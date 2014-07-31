class Chat < ActiveRecord::Base
  acts_as_paranoid

  after_create :update_conversation_read_at

  scope :global, ->{ where("conversation_id IS NULL") }

  belongs_to :user
  belongs_to :conversation

  validates :message, presence: true

  def to_s
    message
  end

  private
  def update_conversation_read_at
    if conversation.present?
      conversation.update_column :updated_at, Time.now
      conversation.read_by! user
    end
  end
end
