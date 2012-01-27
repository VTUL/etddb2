class CreateDocumentTypes < ActiveRecord::Migration
  def change
    create_table :document_types do |t|
      t.string :name
      t.boolean :retired

      t.timestamps
    end
  end
end
