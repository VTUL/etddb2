class SearchController < ApplicationController
	def index
		@etds = []
	    if params[:per_page] =~ /^\d+$/
	      @per_page = params[:per_page]
	    else
	      @per_page = 10
	    end
		# query parameter needed here to expose DSL and allow use of instance
		# variable @per_page
		@search = Etd.search do |query|
			query.fulltext params[:adv_search]
			query.paginate :page => params[:page], :per_page => @per_page
		end

		@etds = @search.results
	end
end
