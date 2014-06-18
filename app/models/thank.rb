class Thank < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def self.thank_stats_for(user)
    Thank.joins(:post).where("posts.author_id = ?", user.id).count
  end
end
