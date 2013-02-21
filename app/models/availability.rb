#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Availability < ActiveRecord::Base
  has_many :etds, inverse_of: :availability
  has_many :contents, inverse_of: :availability
  has_many :provenances, as: :model
  has_many :conversations, as: :model

  belongs_to :reason, inverse_of: :availability
  belongs_to :release_availability, class_name: 'Availability', foreign_key: 'release_availability_id'

  ACCESS_RESTRICTIONS = ['None', 'Restricted', 'Withheld']
  validates :access_restriction, inclusion: {in: ACCESS_RESTRICTIONS}
  validates :retired, inclusion: {in: [true, false], message: "must be boolean"}
  validates :etd_only, inclusion: {in: [true, false], message: "must be boolean"}
  validates :allows_reasons, inclusion: {in: [true, false], message: "must be boolean"}
  validates_presence_of :name, :description, :reason_id
end
