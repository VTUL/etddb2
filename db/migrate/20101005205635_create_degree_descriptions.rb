class CreateDegreeDescriptions < ActiveRecord::Migration
  def self.up
    create_table :degree_descriptions do |t|
      t.integer :etd_id

      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :degree_descriptions
  end
end
