class AddRetiredAtToCopyrightAndPrivacyStatements < ActiveRecord::Migration
  def self.up
    add_column :copyright_statements, :retired_at, :datetime
    add_column :privacy_statements, :retired_at, :datetime
  end

  def self.down
    remove_column :copyright_statements, :retired_at
    remove_column :privacy_statements, :retired_at
  end
end
