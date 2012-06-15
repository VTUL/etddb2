class AddEmailPref < ActiveRecord::Migration
  def up
    change_table :people do |t|
      t.boolean :show_email
    end
  end

  def down
    remove_column :people, :show_email
  end
end
