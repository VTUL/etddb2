class SearchController < ApplicationController
	def index
		@etds = []
		# keys here must match model attributes
		@checkbox_options = {"title" => "Title", "keywords" => "Keywords", 
							 "abstract" => "Abstract", "author" => "Author"}
		@sort_by_options = ["Relevance", "Department", "Defense Date"]
	    if params[:per_page] =~ /^\d+$/
	      @per_page = params[:per_page]
	    else
	      @per_page = 10
	    end
	    
	    if params[:sort_by].blank? 
	    	@sort_by = @sort_by_options[0]
	    else
	    	@sort_by = params[:sort_by]
	    end
	    if params[:adv_search].blank?
	    	@result = "no_search"
	    else
			# query parameter needed here to expose DSL and allow use of instance
			# variable @per_page
			begin
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
					# query.order_by(:degree_id, :asc)
				end

				@etds = search.results
				if search.results.size < 1 
					@result = "none_found"
				else
					@result = search.results
				end
			rescue Exception => ex
				# Catch exceptions, likely due to solr server being down
				@result = "exception"
				@exception_message = ex.message
			end
		end
	end
end
