#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Permission < ActiveRecord::Base
  has_many :digital_objects 
  has_many :actions
  has_many :people
 
  validates_presence_of :id
end
