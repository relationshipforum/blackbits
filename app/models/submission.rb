class Submission < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_paranoid

  scope :not_secret, -> { where("secret IS NOT true") }

  belongs_to :forum
  belongs_to :author, class_name: "User"
  has_many :posts, -> { order "created_at ASC" }, dependent: :destroy
  has_many :views, dependent: :destroy

  validates :title, presence: true
  validates :author_id, presence: true

  def to_s
    title
  end

  def has_posts_by?(user)
    return false unless user
    posts.where(author_id: user.id).exists?
  end

  def first_unread_post(user)
    return posts.first unless user

    view = View.find_by(user_id: user.id, submission_id: id)
    post = nil

    if view
      # First post created AFTER the last view.
      post = posts.where("created_at > ?", view.viewed_at).first
    else
      # If we haven't viewed the thread before, first post.
      post = posts.first
    end

    # If nothing matches, send them to the last post.
    post || posts.last
  end

  def viewed!(user)
    return false unless user

    view = View.find_or_create_by(user_id: user.id, submission_id: id)
    view.update(viewed_at: Time.now)
  end

  def viewed_by?(user, views = nil)
    return true if updated_at < Time.now - 1.week
    return false unless user
    return false unless views

    view = views.find { |v| v.submission_id == id }
    view && view.viewed_at >= updated_at
  end

  def alt_text
    posts.first.body.gsub(/\s+/, " ")[0..255]
  rescue
    ""
  end
end
