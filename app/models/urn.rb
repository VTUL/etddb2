#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Urn < ActiveRecord::Base
  # Associates tables
  belongs_to :etd

  # Validates attributes
  validates :urn, :id, :presence => true
end
