class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.boolean :read, default: false
      t.boolean :archived, default: false
      t.integer :participant_id
      t.integer :conversation_id

      t.timestamps
    end
  end
end
