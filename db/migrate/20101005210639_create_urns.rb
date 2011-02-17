class CreateUrns < ActiveRecord::Migration
  def self.up
    create_table :urns do |t|
      t.string :urn

      t.timestamps
    end
  end

  def self.down
    drop_table :urns
  end
end
