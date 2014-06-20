class Chat < ActiveRecord::Base
  belongs_to :user
  validates :message, presence: true

  def to_s
    message
  end
end
