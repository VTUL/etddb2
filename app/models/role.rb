#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Role < ActiveRecord::Base
  has_many :people_roles, inverse_of: :role
  has_many :people, through: :people_roles
  has_many :etds, through: :people_roles
  has_many :permissions, inverse_of: :role
  has_many :user_actions, through: :permission
  has_many :digital_objects, through: :permission
  has_many :provenances, as: :model
  has_many :conversations, as: :model

  groups = ["Creators", "Collaborators", "Graduate School", "Administration"]
  validates_presence_of :name, :group
  validates :group, inclusion: {in: groups, message: "must be one of our groups."}

end
