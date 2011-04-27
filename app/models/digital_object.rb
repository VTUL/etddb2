#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class DigitalObject < ActiveRecord::Base
#  has_and_belongs_to_many :roles
#  has_and_belongs_to_many :actions
  has_many :permission
  has_many :roles, :through=>:permission
  has_many :actions, :through=>:permission

  validates :name, :presence => true
end
