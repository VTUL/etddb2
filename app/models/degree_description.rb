#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class DegreeDescription < ActiveRecord::Base
  belongs_to :etd

  validates :name, :presence => true
end
