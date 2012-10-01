#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Provenance < ActiveRecord::Base
  belongs_to :person, inverse_of: :created_provenances
  belongs_to :model, polymorphic: true

  has_many :conversations, as: :model
  has_many :provenances, as: :model

  validates_presence_of :person, :action, :model
end
