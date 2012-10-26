class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string :name
      t.string :description
      t.integer :months_to_release
      t.integer :months_to_warning
      t.boolean :warn_before_approval

      t.timestamps
    end
  end
end
