class CreateEtds < ActiveRecord::Migration
  def self.up
    create_table :etds do |t|
      t.text :title
      t.text :abstract
      t.string :bound
      t.string :status
      t.string :urn
      t.string :url
      t.date :ddate
      t.date :sdate
      t.date :adate
      t.date :cdate
      t.date :rdate

      t.integer :availability_id
      t.integer :copyright_statement_id
      t.integer :department_id
      t.integer :document_type_id
      t.integer :privacy_statement_id

      t.timestamps
    end
  end

  def self.down
    drop_table :etds
  end
end
