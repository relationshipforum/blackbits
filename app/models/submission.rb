class Submission < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_paranoid

  belongs_to :forum
  belongs_to :author, class_name: "User"
  has_many :posts, -> { order "created_at ASC" }, dependent: :destroy
  has_many :views, dependent: :destroy

  validates :title, presence: true
  validates :author_id, presence: true

  def to_s
    title
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

  def viewed_by?(user)
    return false unless user

    view = View.select("viewed_at").where(user_id: user.id, submission_id: id).last
    view && view.viewed_at >= updated_at
  end

  def alt_text
    posts.first.body.gsub(/\s+/, " ")[0..255]
  rescue
    ""
  end
end
