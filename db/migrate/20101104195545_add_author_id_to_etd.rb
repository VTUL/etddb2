class AddAuthorIdToEtd < ActiveRecord::Migration
  def self.up
    add_column :etds, :author_id, :integer
  end

  def self.down
    remove_column :etds, :author_id
  end
end
