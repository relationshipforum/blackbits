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

  def viewed!(user)
    return false unless user

    view = View.find_or_create_by(user_id: user.id, submission_id: id)
    view.update(viewed_at: Time.now)
  end

  def viewed_by?(user)
    return false unless user

    view = View.where(user_id: user.id, submission_id: id).first
    view && view.viewed_at >= updated_at
  end
end
