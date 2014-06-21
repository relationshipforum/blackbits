class AddPrivateToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :private, :boolean, default: false
  end
end
