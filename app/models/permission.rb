#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Permission < ActiveRecord::Base
  belongs_to :digital_object, inverse_of: :permissions
  belongs_to :user_action, inverse_of: :permissions
  belongs_to :role, inverse_of: :permissions

  has_many :provenances, as: :model
  has_many :conversations, as: :model

  validates_presence_of :role_id, :user_action_id, :digital_object_id
end
