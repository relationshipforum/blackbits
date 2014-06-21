class AddPostsCountToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :posts_count, :integer, default: 0

    Submission.all.each { |s| Submission.update_counters s.id, posts_count: s.posts.count }
  end
end
