class AddWhatsNewDefaultToUsers < ActiveRecord::Migration
  def change
    add_column :users, :whats_new_default, :boolean
  end
end
