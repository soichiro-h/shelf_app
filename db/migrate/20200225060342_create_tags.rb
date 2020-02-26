class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :tag_title
      t.references :user, foreign_key: true

      t.timestamps
    end
      add_index :tags, [:user_id, :created_at]
  end
end
