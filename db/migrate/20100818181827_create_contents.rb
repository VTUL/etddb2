class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      #t.has_attached_file :content
      t.string :content
      t.boolean :bound
      t.string :title
      t.text :description

      t.integer :etd_id
      t.integer :availability_id

      t.integer :page_count
      t.integer :duration
      t.string :dimensions

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
