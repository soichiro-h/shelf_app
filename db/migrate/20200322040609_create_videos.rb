# frozen_string_literal: true

class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :video_id
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
