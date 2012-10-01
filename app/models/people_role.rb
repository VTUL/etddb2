#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class PeopleRole < ActiveRecord::Base
  #Specify irregular table names
  self.table_name = "people_roles"

  belongs_to :person, class_name: "LegacyPerson", inverse_of: :people_roles
  belongs_to :role, inverse_of: :people_roles
  belongs_to :etd, inverse_of: :people_roles

  has_many :provenances, as: :model
  has_many :conversations, as: :model

  #Validate attributes
  validates_presence_of :person_id, :role_id
end
