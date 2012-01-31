class CreateEtdsDepartmentsJoinTable < ActiveRecord::Migration
  def up
    create_table :departments_etds, :id => false do |t|
      t.integer :etd_id
      t.integer :department_id
    end
  end

  def down
    drop_table :departments_etds
  end
end
