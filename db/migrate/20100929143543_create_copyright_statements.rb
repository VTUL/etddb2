class CreateCopyrightStatements < ActiveRecord::Migration
  def self.up
    create_table :copyright_statements do |t|
      t.integer :etd_id

      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :copyright_statements
  end
end
