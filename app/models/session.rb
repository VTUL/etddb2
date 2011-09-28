#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Session < ActiveRecord::Base

  # Validates attributes
  validates :data, :presence => true

end
