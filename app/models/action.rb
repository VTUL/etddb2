#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Action < ActiveRecord::Base
#  has_and_belongs_to_many :roles
#  has_and_belongs_to_many :digital_objects
  has_many :permission
  has_many :roles, :through=>:permission
  has_many :digital_objects, :through=>:permission
  validates :name, :presence => true
  validates :id, :presence => true
end
