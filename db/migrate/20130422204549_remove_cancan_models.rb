class RemoveCancanModels < ActiveRecord::Migration
  def up
    drop_table :digital_objects
    drop_table :user_actions
    drop_table :permissions
  end

  def down
    create_table :digital_objects do |t|
      t.string :name

      t.timestamps
    end

    create_table :user_actions do |t|
      t.string :name

      t.timestamps
    end

    create_table :permissions do |t|
      t.integer :user_action_id
      t.integer :role_id
      t.integer :digital_object_id

      t.timestamps
    end
  end
end
