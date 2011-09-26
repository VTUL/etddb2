class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|

      t.integer :etd_id

      t.string :uploaded_file_name
      t.string :uploaded_content_type
      t.integer :uploaded_file_size
      t.timestamp :uploaded_updated_at
      t.string :availability
      t.string :bound
      t.integer :page_count
      t.timestamp :timestamp

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
