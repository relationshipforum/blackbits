class Thank < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def self.thank_stats_for(user)
    query = Thank.joins(:post).where("posts.author_id = ?", user.id)
    posts = query.select("DISTINCT thanks.post_id")

    "#{query.count} times, #{posts.count} posts"
  end
end
