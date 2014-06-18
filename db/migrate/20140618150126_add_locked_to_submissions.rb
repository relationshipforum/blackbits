class AddLockedToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :locked, :boolean
  end
end
