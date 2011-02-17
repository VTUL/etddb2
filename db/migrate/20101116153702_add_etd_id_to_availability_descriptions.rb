class AddEtdIdToAvailabilityDescriptions < ActiveRecord::Migration
  def self.up
    add_column :availability_descriptions, :etd_id, :integer
  end

  def self.down
    remove_column :availability_descriptions, :etd_id
  end
end
