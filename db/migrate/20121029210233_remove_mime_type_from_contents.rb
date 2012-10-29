class RemoveMimeTypeFromContents < ActiveRecord::Migration
  def up
    remove_column :contents, :mime_type
  end

  def down
    add_column :contents, :mime_type, :string
  end
end
