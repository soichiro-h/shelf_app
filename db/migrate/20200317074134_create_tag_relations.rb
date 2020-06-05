# frozen_string_literal: true

class CreateTagRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_relations do |t|
      t.integer :tag_id
      t.integer :book_id

      t.timestamps
    end

    add_index :tag_relations, :tag_id
    add_index :tag_relations, :book_id
    add_index :tag_relations, %i[tag_id book_id], unique: true
  end
end
