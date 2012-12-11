class AddAllowsReasonsToAvailability < ActiveRecord::Migration
  def change
    add_column :availabilities, :allows_reasons, :boolean
    add_column :availabilities, :etd_only, :boolean
  end
end
