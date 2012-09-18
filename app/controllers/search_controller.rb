class SearchController < ApplicationController
	def index
		@etds = []
		# keys here must match model attributes
		@checkbox_options = {"title" => "Title", "keywords" => "Keywords", 
							 "abstract" => "Abstract"}
	    if params[:per_page] =~ /^\d+$/
	      @per_page = params[:per_page]
	    else
	      @per_page = 10
	    end
	    
	    if params[:adv_search].blank?
	    	@no_search = true
	    else
			# query parameter needed here to expose DSL and allow use of instance
			# variable @per_page
			search = Etd.search do |query|
				if params[:search_using].blank?
					# User has no checkboxes set to delimit search, 
					# default search in this case goes here
					fields = "title"
				else
					# Grab selected keys (for all options, see @checkbox_options), 
					# use as fields to search through
					fields = params[:search_using].keys
				end
				query.keywords params[:adv_search], :fields => fields
				query.paginate :page => params[:page], :per_page => @per_page
			end

			@etds = search.results
		end
	end
end
