class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :userId, null: false, foreign_key: true
      t.references :postId, null: false, foreign_key: true
      t.string :text
      t.date :updated_at
      t.date :created_at

      t.timestamps
    end
  end
end
