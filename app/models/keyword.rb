#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Keyword < ActiveRecord::Base
  belongs_to :etd

  validates_presence_of :word
  validates_uniqueness_of :word
end
