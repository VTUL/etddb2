class AddReleaseAvailabilityIdToAvailability < ActiveRecord::Migration
  def change
    add_column :availabilities, :release_availability_id, :integer
  end
end
