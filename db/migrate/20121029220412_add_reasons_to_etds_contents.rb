class AddReasonsToEtdsContents < ActiveRecord::Migration
  def change
    add_column :etds, :reason_id, :integer
    add_column :contents, :reason_id, :integer
  end
end
