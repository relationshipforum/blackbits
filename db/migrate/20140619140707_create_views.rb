class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :submission_id
      t.integer :user_id
      t.datetime :viewed_at

      t.timestamps
    end

    add_index :views, :submission_id
    add_index :views, :user_id
  end
end
