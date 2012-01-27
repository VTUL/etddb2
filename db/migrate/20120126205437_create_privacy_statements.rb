class CreatePrivacyStatements < ActiveRecord::Migration
  def change
    create_table :privacy_statements do |t|
      t.string :name
      t.string :description
      t.boolean :retired

      t.timestamps
    end
  end
end
