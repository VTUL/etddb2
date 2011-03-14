class CreateDigitalObjects < ActiveRecord::Migration
  def self.up
    create_table :digital_objects do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :digital_objects
  end
end
