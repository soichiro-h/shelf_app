class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :proper_title
      t.integer :price
      t.string :author
      t.string :image
      t.text :memo
      t.text :summary
      t.text :related_videos
      t.boolean :favorite
      t.boolean :own

      t.timestamps
    end
  end
end
