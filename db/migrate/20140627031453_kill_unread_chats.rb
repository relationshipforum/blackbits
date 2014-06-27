class KillUnreadChats < ActiveRecord::Migration
  def change
    remove_column :users, :last_chatted_at
  end
end
