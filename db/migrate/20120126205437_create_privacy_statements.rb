class CreatePrivacyStatements < ActiveRecord::Migration
  def change
    create_table :privacy_statements do |t|
      t.string :statement
      t.boolean :retired

      t.timestamps
    end
  end
end
