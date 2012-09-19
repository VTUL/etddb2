class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :subject
      t.integer :model_id
      t.string :model_type

      t.timestamps
    end
  end
end
