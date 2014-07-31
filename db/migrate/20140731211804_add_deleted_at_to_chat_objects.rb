class AddDeletedAtToChatObjects < ActiveRecord::Migration
  def change
    add_column :chats, :deleted_at, :datetime
    add_column :conversations, :deleted_at, :datetime
    add_column :conversations_users, :deleted_at, :datetime
  end
end
