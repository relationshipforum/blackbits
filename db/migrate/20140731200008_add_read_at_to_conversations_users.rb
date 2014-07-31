class AddReadAtToConversationsUsers < ActiveRecord::Migration
  def change
    add_column :conversations_users, :read_at, :datetime
  end
end
