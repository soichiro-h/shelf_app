class AddIntroduceCommentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :introduce_comment, :text
  end
end
