class Post < ActiveRecord::Base
  paginates_per 10

  default_scope { order("created_at ASC") }

  after_create :update_submission
  after_destroy :update_submission

  belongs_to :author, class_name: "User"
  belongs_to :submission, inverse_of: :posts
  has_many :thanks, dependent: :destroy

  validates :body, presence: true
  validates :author_id, presence: true
  validates :submission_id, presence: true

  validate do |post|
    if post.new_record?
      last_post = post.author.posts.last

      if last_post.present? && Time.now - last_post.created_at < 10.seconds
        post.errors.add(:base, "Wait 10 seconds before posting.")
      end
    end
  end

  def thanks!(user)
    return if user == author

    thanks = Thank.where(post_id: id, user_id: user.id).first

    if thanks
      thanks.destroy
    else
      Thank.create(post_id: id, user_id: user.id)
    end
  end

  private
  def update_submission
    submission.update_attributes(updated_at: submission.posts.last.created_at)
  end
end
