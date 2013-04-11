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

  GROUPS = ["Creators", "Collaborators", "Graduate School", "Administration"]

  validates_presence_of :name, :group, :priority
  validates :group, inclusion: {in: GROUPS, message: "must be one of our groups."}
  validates :priority, numericality: { only_interger: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

end
