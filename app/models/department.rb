#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Department < ActiveRecord::Base
  belongs_to :etd

  validates :name, :id, :presence => true
end
