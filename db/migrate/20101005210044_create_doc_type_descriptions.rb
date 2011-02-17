class CreateDocTypeDescriptions < ActiveRecord::Migration
  def self.up
    create_table :doc_type_descriptions do |t|
      t.integer :etd_id

      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :doc_type_descriptions
  end
end
