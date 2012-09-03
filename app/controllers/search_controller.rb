class SearchController < ApplicationController
	def index
		@etds = []
	    if params[:per_page] =~ /^\d+$/
	      @per_page = params[:per_page]
	    else
	      @per_page = 10
	    end
		#@etds = Etd.search(params[:adv_search]).paginate(page: params[:page], :per_page => @per_page, include: :people, order: 'people.last_name')
		search = Etd.search do 
			fulltext params[:adv_search]
			paginate :page => params[:page], :per_page => params[:per_page]
		end

		@etds = search.results
	end
end
