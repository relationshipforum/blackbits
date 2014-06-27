class AddForceChatToUsers < ActiveRecord::Migration
  def change
    add_column :users, :force_chat, :boolean
  end
end
