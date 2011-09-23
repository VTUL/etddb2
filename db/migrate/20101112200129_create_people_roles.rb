class CreatePeopleRoles < ActiveRecord::Migration
  def self.up
    create_table :people_roles do |t|
      t.integer :person_id
      t.integer :role_id
      t.integer :etd_id
    end

    # Indexes are important for performance if join tables grow big
    add_index :people_roles, [:person_id, :role_id, :etd_id], :unique => true
    add_index :people_roles, :role_id, :unique => false
    add_index :people_roles, :etd_id, :unique => false
  end

  def self.down
    drop_table :people_roles
  end
end
