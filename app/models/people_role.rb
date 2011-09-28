#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class PeopleRole < ActiveRecord::Base
  #Specify irregular table names
  self.table_name = "people_roles"

  #Associate tables
#  has_many :people
#  has_many :roles
#  has_and_belongs_to_many :etds
#  has_many :etds
  belongs_to :person
  belongs_to :role
  belongs_to :etd

  #Validate attributes
  validates :person_id, :role_id, :presence => true
end
