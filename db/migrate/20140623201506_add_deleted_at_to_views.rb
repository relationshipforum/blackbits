class AddDeletedAtToViews < ActiveRecord::Migration
  def change
    add_column :views, :deleted_at, :datetime
    add_index :views, :deleted_at
  end
end
