class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
    add_index :forums, :title, unique: true
  end
end
