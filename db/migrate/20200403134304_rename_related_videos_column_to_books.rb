# frozen_string_literal: true

class RenameRelatedVideosColumnToBooks < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :related_videos, :purchase_url
  end
end
