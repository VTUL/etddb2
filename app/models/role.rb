#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Role < ActiveRecord::Base
  #Associate tables
#  has_and_belongs_to_many :people
#  has_and_belongs_to_many :actions 
#  has_and_belongs_to_many :digital_objects
  has_many :permission
  has_many :actions, :through=>:permission 
  has_many :digital_objects, :through=>:permission

  # Validates attributes
  validates :name, :presence => true

end


