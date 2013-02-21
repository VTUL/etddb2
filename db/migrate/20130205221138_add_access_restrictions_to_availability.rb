class AddAccessRestrictionsToAvailability < ActiveRecord::Migration
  def change
    add_column :availabilities, :access_restriction, :string
  end
end
