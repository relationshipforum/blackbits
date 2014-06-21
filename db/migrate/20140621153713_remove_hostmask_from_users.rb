class RemoveHostmaskFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :hostmask, :string
  end
end
