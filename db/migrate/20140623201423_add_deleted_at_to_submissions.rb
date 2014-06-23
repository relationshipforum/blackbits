class AddDeletedAtToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :deleted_at, :datetime
    add_index :submissions, :deleted_at
  end
end
