class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.string :name
      t.boolean :retired

      t.timestamps
    end

    create_table :etds_departments
      t.integer :etd_id
      t.integer :department_id
    end
  end

  def self.down
    drop_table :departments
    #drop_table :etds_departments
  end
end
