class AddAgentAndHostmaskToUsers < ActiveRecord::Migration
  def change
    add_column :users, :agent, :string
    add_column :users, :hostmask, :string
  end
end
