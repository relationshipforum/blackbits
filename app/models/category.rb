class Category < ActiveRecord::Base
  has_many :forums
  validates :title, presence: true

  def to_s
    title
  end
end
