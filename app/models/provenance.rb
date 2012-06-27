#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class Provenance < ActiveRecord::Base
  belongs_to :person
  belongs_to :model, polymorphic: true
end
