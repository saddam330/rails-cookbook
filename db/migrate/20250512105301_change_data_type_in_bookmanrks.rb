class ChangeDataTypeInBookmanrks < ActiveRecord::Migration[7.1]
  def change
    change_column :bookmarks, :comment, :text
  end
end
