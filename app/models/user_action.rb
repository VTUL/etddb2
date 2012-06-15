#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class UserAction < ActiveRecord::Base
  has_many :permission
  has_many :roles, through: :permission
  has_many :digital_objects, through: :permission

  validates_presence_of :name
end
