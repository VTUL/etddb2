class AddPaperclip < ActiveRecord::Migration
  def self.up
    remove_column :contents, :content
    change_table :contents do |t|
      t.has_attached_file :content
    end
  end

  def self.down
    drop_attached_file :contents, :content
    add_column :contents, :content, :string
  end
end
