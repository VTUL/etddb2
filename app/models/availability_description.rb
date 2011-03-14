#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class AvailabilityDescription < ActiveRecord::Base
#  belongs_to :etd 
  validates_presence_of :availability, :description 
end
