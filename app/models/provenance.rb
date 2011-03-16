#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Provenance < ActiveRecord::Base
  # Associate tables
  belongs_to :etd

  # Validate attributes
  validates :creator, :notice, :presence => true
end
