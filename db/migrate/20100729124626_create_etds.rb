class CreateEtds < ActiveRecord::Migration
  def self.up
    create_table :etds do |t|
      t.text :title
      t.text :abstract
      t.boolean :bound
      t.text :keywords
      t.string :status
      t.string :urn
      t.string :url
      t.date :defense_date
      t.date :submission_date
      t.date :approval_date
      t.date :release_date

      t.integer :copyright_statement_id
      t.integer :degree_id
      t.integer :document_type_id
      t.integer :privacy_statement_id
      t.integer :release_manager_id

      t.timestamps
    end
  end

  def self.down
    drop_table :etds
  end
end
