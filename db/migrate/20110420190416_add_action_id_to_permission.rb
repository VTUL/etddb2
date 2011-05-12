class AddActionIdToPermission < ActiveRecord::Migration
  def self.up
      add_column :permissions, :action_id, :integer
      add_column :permissions, :role_id, :integer
      add_column :permissions, :digital_object_id, :integer
 
  end

  def self.down
      remove_column :permissions, :action_id
      remove_column :permissions, :role_id
      remove_column :permissions, :digital_object_id
  end
end
