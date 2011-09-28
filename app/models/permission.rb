#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Permission < ActiveRecord::Base
  belongs_to :digital_object
  belongs_to :action
  belongs_to :role

#  validates  :presence => true
end
