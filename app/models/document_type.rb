#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class DocumentType < ActiveRecord::Base
  has_many :etds

  validates_presence_of :name
end
