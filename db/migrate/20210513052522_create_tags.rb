class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :tag_name
      t.integer :genre_id, default: 1

      t.timestamps
    end
  end
end
