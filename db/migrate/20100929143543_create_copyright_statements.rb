class CreateCopyrightStatements < ActiveRecord::Migration
  def self.up
    create_table :copyright_statements do |t|
      t.string :statement
      t.boolean :retired

      t.timestamps
    end
  end

  def self.down
    drop_table :copyright_statements
  end
end
