class FixProvenances < ActiveRecord::Migration
  def up
    remove_column :provenances, :creator
    remove_column :provenances, :notice
    remove_column :provenances, :etd_id
    change_table :provenances do |t|
      t.integer :person_id
      t.integer :model_id
      t.string :model_type
      t.string :action
      t.string :message
    end
  end

  def down
    remove_column :provenances, :person_id
    remove_column :provenances, :model_id
    remove_column :provenances, :model_type
    remove_column :provenances, :action
    remove_column :provenances, :message
    change_table :provenances do |t|
      t.integer :etd_id
      t.string :creator
      t.string :notice
    end
  end
end
