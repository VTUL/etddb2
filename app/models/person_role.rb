#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class PersonRole < ActiveRecord::Base

  has_many :people
  has_many :roles

  validates_presence_of :id
end
