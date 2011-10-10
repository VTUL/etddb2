class AddDimensionsDurationToContents < ActiveRecord::Migration
  def self.up
        change_table :contents do |t|
            t.integer :duration
            t.string :dimensions
        end
  end

  def self.down
        remove_column :contents, :duration
        remove_column :contents, :dimensions
  end
end
