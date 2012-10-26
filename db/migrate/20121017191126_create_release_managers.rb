class CreateReleaseManagers < ActiveRecord::Migration
  def change
    create_table :release_managers do |t|
      t.string :other_reason_desc

      t.integer :availability_id
      t.integer :reason_id
    end
  end
end
