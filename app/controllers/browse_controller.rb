#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-16-2011
#########################################################

class BrowseController < ApplicationController
  # browser by author
  def browse_by_author
    @etds = Etd.find_etds_for_browsing_by_author(params[:letter])
  end
  # browser by department 
  def browse_by_department
    @etds = Etd.find_etds_for_browsing_by_department(params[:letter])
  end

  # browser by advisor 
  def browse_by_advisor
    @etds = Etd.find_etds_for_browsing_by_advisor(params[:letter])
  end

  def index
  end
  # find etds for view and show them
  def show
    @etd = Etd.find_etds_for_view(params[:id])
    @contents = Content.find_contents_for_view(params[:id])
  end

  def login
  end
end
