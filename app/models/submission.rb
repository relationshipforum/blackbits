class Submission < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :forum
  belongs_to :author, class_name: "User"
  has_many :posts, dependent: :destroy

  validates :title, presence: true
  validates :author_id, presence: true

  def to_s
    title
  end
end
