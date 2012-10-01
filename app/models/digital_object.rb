#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class DigitalObject < ActiveRecord::Base
  has_many :permissions, inverse_of: :digital_object
  has_many :roles, through: :permission
  has_many :user_actions, through: :permission

  validates_presence_of :name
end
