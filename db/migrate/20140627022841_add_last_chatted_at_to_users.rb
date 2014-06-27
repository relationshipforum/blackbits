class AddLastChattedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_chatted_at, :datetime

    User.all.each { |u| u.last_chatted_at = Time.now; u.save }
  end
end
