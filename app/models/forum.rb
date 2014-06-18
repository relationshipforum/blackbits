class Forum < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :submissions

  def to_s
    title
  end

  def self.default_forum_id
    Forum.select(:id).where(title: "Love Advice").first.id
  end
end
