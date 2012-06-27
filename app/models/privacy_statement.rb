#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class PrivacyStatement < ActiveRecord::Base
  has_many :etds
  has_many :provenances, as: :model

  validates_presence_of :statement
  validates :retired, inclusion: {in: [true, false], message: "must be boolean"}
end
