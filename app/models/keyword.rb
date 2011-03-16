#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Mar-15-2011
#########################################################

class Keyword < ActiveRecord::Base
  belongs_to :etd

  validates :word, :presence => true
  validates :word, :uniqueness => true
end
