class Post < ActiveRecord::Base
  after_create :update_submission

  belongs_to :author, class_name: "User"
  belongs_to :submission, inverse_of: :posts
  has_many :thanks, dependent: :destroy

  validates :body, presence: true
  validates :author_id, presence: true
  validates :submission_id, presence: true

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
    submission.update(updated_at: Time.now)
  end
end
