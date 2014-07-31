class RecreateConversationsUsers < ActiveRecord::Migration
  def change
    drop_table :conversations_users

    create_table :conversations_users do |t|
      t.integer :conversation_id
      t.integer :user_id
      t.datetime :read_at
    end

    add_index(:conversations_users, [:conversation_id, :user_id], unique: true)
  end
end
