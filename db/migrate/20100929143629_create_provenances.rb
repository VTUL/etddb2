class CreateProvenances < ActiveRecord::Migration
  def self.up
    create_table :provenances do |t|
      t.integer :etd_id

      t.string :creator
      t.string :notice

      t.timestamps
    end
  end

  def self.down
    drop_table :provenances
  end
end
