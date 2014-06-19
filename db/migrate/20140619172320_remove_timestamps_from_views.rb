class RemoveTimestampsFromViews < ActiveRecord::Migration
  def change
    remove_column :views, :created_at
    remove_column :views, :updated_at
  end
end
