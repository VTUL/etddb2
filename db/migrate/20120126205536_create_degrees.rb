class CreateDegrees < ActiveRecord::Migration
  def change
    create_table :degrees do |t|
      t.string :name
      t.boolean :retired

      t.timestamps
    end
  end
end
