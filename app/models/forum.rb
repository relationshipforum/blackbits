class Forum < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :category
  has_many :submissions, dependent: :destroy
  has_many :posts, through: :submissions

  validates :title, presence: true
  validates :category_id, presence: true

  def to_s
    title
  end

  def self.default_forum_id
    Forum.select(:id).where(title: "Love Advice").first.id
  end
end
