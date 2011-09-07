#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class PersonRole < ActiveRecord::Base
  #Specify irregular table names
  self.table_name = "people_roles"

  #Associate tables
  has_many :people
  has_many :roles
  has_and_belongs_to_many :etds

  #Validate attributes
  validates :id, :person_id, :role_id, :presence => true
end
