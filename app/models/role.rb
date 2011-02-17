#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Role < ActiveRecord::Base
  has_and_belongs_to_many :people

  has_and_belongs_to_many :actions

  has_and_belongs_to_many :digital_objects

  validates_presence_of :name

end


