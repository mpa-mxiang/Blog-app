class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :authorId, null: false, foreign_key: true
      t.string :title
      t.string :text
      t.date :updated_at
      t.date :created_at
      t.integer :commentsCounter
      t.integer :likesCounter

      t.timestamps
    end
  end
end
