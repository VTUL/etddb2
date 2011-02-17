class CreateAvailabilityDescriptions < ActiveRecord::Migration
  def self.up
    create_table :availability_descriptions do |t|
      t.integer :etd_id

      t.string :availability
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :availability_descriptions
  end
end
