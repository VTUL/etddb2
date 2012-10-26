class ReleaseManager < ActiveRecord::Base
  belongs_to :availability, inverse_of: :release_managers
  belongs_to :reason, inverse_of: :release_managers

  has_one :etd, inverse_of: :release_manager

  has_many :contents, inverse_of: :release_managers

  validates_presence_of :availability_id
  #validates_presence_of :reason_id, if: :requires_a_reason?
  
  def requires_a_reason?
    Availability.find(availability_id).name == 'Withheld'
  end
end
