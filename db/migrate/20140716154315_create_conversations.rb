class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :user_id
      t.timestamps
    end

    create_table :conversations_users, { id: false } do |t|
      t.integer :conversation_id
      t.integer :user_id
    end

    add_index :conversations, :user_id
  end
end
