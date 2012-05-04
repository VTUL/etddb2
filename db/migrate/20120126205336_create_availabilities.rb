class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.string :name
      t.string :description
      t.boolean :retired

      t.timestamps
    end
  end
end
