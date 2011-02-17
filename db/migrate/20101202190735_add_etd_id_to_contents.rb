class AddEtdIdToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :etd_id, :integer
  end

  def self.down
    remove_column :contents, :etd_id
  end
end
