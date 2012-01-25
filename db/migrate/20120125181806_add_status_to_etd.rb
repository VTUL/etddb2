class AddStatusToEtd < ActiveRecord::Migration
  def change
    add_column :etds, :status, :string
  end
end
