class CreateActionRoleDigitalObject < ActiveRecord::Migration
  def self.up
    create_table :actions_roles_digital_objects, :id => false do |t|
      t.integer :action_id
      t.integer :role_id
      t.integer :digital_object_id
    end

    # Indexes
      add_index :actions_roles_digital_objects, [:role_id, :action_id,  :digital_object_id], :unique => true, :name => "index_actions_roles_digital_objects"
      add_index :actions_roles_digital_objects, :action_id,  :unique => false
      add_index :actions_roles_digital_objects, :digital_object_id,  :unique => false
  end

  def self.down
    drop_table :actions_roles_digital_objects
  end
end
