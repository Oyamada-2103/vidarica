class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|
      t.text :comment
      t.references :user, foreign_key: true
      t.references :post_image, foreign_key: true

      t.timestamps
    end
  end
end
