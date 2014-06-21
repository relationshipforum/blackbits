class RemovePrivateFromSubmissions < ActiveRecord::Migration
  def change
    remove_column :submissions, :private, :boolean
  end
end
