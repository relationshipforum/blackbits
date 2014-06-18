class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :title
      t.text :body
      t.integer :author_id
      t.integer :forum_id

      t.timestamps
    end
  end
end
