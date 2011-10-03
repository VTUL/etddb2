#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Audio < Content
  validates_presence_of :duration
  validates_numericality_of :duration
end
