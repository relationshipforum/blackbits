class Thank < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  belongs_to :post

  after_save :clear_post_cache
  after_destroy :clear_post_cache

  def self.thank_stats_for(user)
    query = Thank.joins(:post).where("posts.author_id = ?", user.id)
    posts = query.select("DISTINCT thanks.post_id")

    "#{query.count} times, #{posts.count} posts"
  end

  private
  def clear_post_cache
    post.clear_cache
  end
end
