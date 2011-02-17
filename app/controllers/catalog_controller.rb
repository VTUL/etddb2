#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech. 
# Last updated: Feb-16-2011
#########################################################

class CatalogController < ApplicationController
  # Show etds in the catalog queue
  def index_etd
    @etds = Etd.all
    respond_to do |format|
      format.html #=new.html.erb
      format.xml { render :xml => @etds}
    end
  end

  # Catalog each ETD
  def catalogETD
  end

  # Export MARC record
  def exportMARC
  end

  # Set the attribute 'cataloged' of ETD as 'yes'
  def markAsCataloged
  end

end
