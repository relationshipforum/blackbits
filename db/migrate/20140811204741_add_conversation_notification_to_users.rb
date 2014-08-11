class AddConversationNotificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :conversation_notification, :boolean, default: true
  end
end
