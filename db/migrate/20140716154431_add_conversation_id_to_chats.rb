class AddConversationIdToChats < ActiveRecord::Migration
  def change
    add_column :chats, :conversation_id, :integer
    add_index :chats, :conversation_id
  end
end
