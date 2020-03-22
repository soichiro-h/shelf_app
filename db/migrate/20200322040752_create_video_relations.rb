class CreateVideoRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :video_relations do |t|
      t.integer :video_id
      t.integer :book_id

      t.timestamps
    end
    
    add_index :video_relations, :video_id
    add_index :video_relations, :book_id
    add_index :video_relations, [:video_id, :book_id], unique: true
    
  end
end
