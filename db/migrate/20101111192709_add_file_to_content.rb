class AddFileToContent < ActiveRecord::Migration
  def self.up
    add_column :contents, :file_id, :integer
    add_column :contents, :file_type, :string
  end

  def self.down
    remove_column :contents, :file_type
    remove_column :contents, :file_id
  end
end
