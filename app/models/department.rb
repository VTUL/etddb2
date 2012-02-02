#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Department < ActiveRecord::Base
  has_and_belongs_to_many :etds

  validates_presence_of :name
end
