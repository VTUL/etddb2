class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.integer :etd_id
      t.integer :availability_id

      t.string :uploaded_file_name
      t.string :uploaded_content_type
      t.integer :uploaded_file_size
      t.timestamp :uploaded_updated_at
      t.string :bound
      t.integer :page_count

      t.integer :file_id
      t.string :file_type

      t.integer :duration
      t.string :dimensions

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
