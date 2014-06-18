class RemoveBodyFromSubmissions < ActiveRecord::Migration
  def change
    remove_column :submissions, :body, :text
  end
end
