#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Document < Content
  validates_presence_of :page_count
  validates_numericality_of :page_count
end
