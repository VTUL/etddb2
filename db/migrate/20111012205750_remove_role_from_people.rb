class RemoveRoleFromPeople < ActiveRecord::Migration
  def self.up
    remove_column :people, :role
  end

  def self.down
    add_column :people, :role
  end
end
