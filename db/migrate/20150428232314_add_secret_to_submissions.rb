class AddSecretToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :secret, :boolean
  end
end
