class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|

      t.integer :etd_id

      t.string :filename
      t.string :types
      t.string :size
      t.string :availability
      t.string :bound
      t.integer :page_count
      t.timestamp :timestamp

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
