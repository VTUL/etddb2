#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class PeopleRole < ActiveRecord::Base
  #Specify irregular table names
  self.table_name = "people_roles"

  belongs_to :person
  belongs_to :role
  belongs_to :etd

  has_many :provenances, as: :model

  #Validate attributes
  validates_presence_of :person_id, :role_id
end
