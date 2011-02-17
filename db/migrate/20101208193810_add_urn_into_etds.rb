class AddUrnIntoEtds < ActiveRecord::Migration
  def self.up
    add_column :etds, :urn, :string    
  end

  def self.down
    remove_column :etds, :urn
  end
end
