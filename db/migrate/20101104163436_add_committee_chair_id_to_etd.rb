class AddCommitteeChairIdToEtd < ActiveRecord::Migration
  def self.up
    add_column :etds, :committee_chair_id, :integer
  end

  def self.down
    remove_column :etds, :committee_chair_id
  end
end
