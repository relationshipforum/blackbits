class AddTitleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string, default: "Registered User"
  end
end
