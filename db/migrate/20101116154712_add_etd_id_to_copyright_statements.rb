class AddEtdIdToCopyrightStatements < ActiveRecord::Migration
  def self.up
    add_column :copyright_statements, :etd_id, :integer
  end

  def self.down
    remove_column :copyright_statements, :etd_id
  end
end
