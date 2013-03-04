class AddChecksumToContent < ActiveRecord::Migration
  def self.up
    add_column :contents, :content_fingerprint, :string
  end

  def self.down
    remove_column :contents, :content_fingerprint
  end
end
