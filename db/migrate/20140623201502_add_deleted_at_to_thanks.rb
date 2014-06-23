class AddDeletedAtToThanks < ActiveRecord::Migration
  def change
    add_column :thanks, :deleted_at, :datetime
    add_index :thanks, :deleted_at
  end
end
