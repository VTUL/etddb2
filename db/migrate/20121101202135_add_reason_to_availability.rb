class AddReasonToAvailability < ActiveRecord::Migration
  def change
    add_column :availabilities, :reason_id, :integer
  end
end
