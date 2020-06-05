# frozen_string_literal: true

class AddDeletedAtToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :deleted_at, :date
  end
end
