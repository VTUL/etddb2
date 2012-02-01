#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Oct-03-2011
#########################################################

class Picture < Content
  validates_presence_of :dimensions
end
