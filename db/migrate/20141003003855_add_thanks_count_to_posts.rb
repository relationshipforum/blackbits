class AddThanksCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :thanks_count, :integer

    Post.all.each do |post|
      Post.reset_counters(post.id, :thanks)
    end
  end
end
