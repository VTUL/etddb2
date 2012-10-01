#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class DocumentType < ActiveRecord::Base
  has_many :etds, inverse_of: :document_type
  has_many :provenances, as: :model
  has_many :conversations, as: :model

  validates_presence_of :name
  validates :retired, inclusion: {in: [true, false], message: "must be boolean"}
end
