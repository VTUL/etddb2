class CreateEtdsPeople < ActiveRecord::Migration
  def self.up
    create_table :etds_people, :id => false do |t|
      t.integer :etd_id
      t.integer :person_id
    end
    
    # Indexes are important for persormance if join tables grow big
    add_index :etds_people, [:etd_id, :person_id], :unique => true
    add_index :etds_people, :person_id, :unique => false
  end

  def self.down
	drop_table :etds_people
  end
end
