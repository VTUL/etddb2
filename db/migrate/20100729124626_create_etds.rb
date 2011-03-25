class CreateEtds < ActiveRecord::Migration
  def self.up
    create_table :etds do |t|
      t.string :urn
      t.string :degree
      t.string :department
      t.string :dtype
      t.text :title
      t.text :abstract
      t.string :availability
      t.text :availability_description
      t.text :copyright_statement
      t.date :ddate
      t.date :sdate
      t.date :adate
      t.date :cdate
      t.date :rdate
      t.string :pid
      t.string :url
      t.timestamp :timestamp
      t.string :bound

      t.timestamps
    end
  end

  def self.down
    drop_table :etds
  end
end
