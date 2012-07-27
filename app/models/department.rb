#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Department < ActiveRecord::Base
  has_many :provenances, as: :model
  #has_many :messages, as: :model

  has_and_belongs_to_many :etds

  validates_presence_of :name
  validates :retired, inclusion: {in: [true, false], message: "must be boolean"}
end
