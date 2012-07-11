class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :msg
      t.integer :sender_id
      t.integer :recipient_id
      t.boolean :read
      t.integer :model_id
      t.string :model_type

      t.timestamps
    end
  end
end
