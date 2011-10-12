class IndexPidOnPerson < ActiveRecord::Migration
  def self.up
    add_index :people, :pid, :unique => true
  end

  def self.down
    remove_index :people, :pid
  end
end
