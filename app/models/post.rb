class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :submission, inverse_of: :posts

  validates :body, presence: true
  validates :author_id, presence: true
  validates :submission_id, presence: true
end
