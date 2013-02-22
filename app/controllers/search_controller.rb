class SearchController < ApplicationController

	def index
		@etds = []
		# Keys here must match model attributes
		@checkbox_options = {"title" => "Title", "keywords" => "Keywords", 
							 "abstract" => "Abstract", "author" => "Author", 
							 "urn" => "URN", "committee" => "Committee Members",
							 "etd_attachment" => "Attachments"}
		# ETDs that non-admins can see
		patron_availabilities = ['Unrestricted', 'Restricted']
		@results_info = nil
	    if isInt(params[:per_page])
	      @per_page = params[:per_page]
	    else
	      @per_page = 10
	    end

		begin
			# query parameter needed here to expose DSL and allow use of instance
			# variable @per_page
			@search = Etd.search do |query|
				if params[:search_using].blank?
					# User has no checkboxes set to delimit search, 
					# default search fields in this case goes here
					fields = "title"
				else
					# Grab selected keys (for all options, see @checkbox_options), 
					# use as fields to search through
					fields = params[:search_using].keys
				end
				# Query set up
				query.order_by(:title, :asc) if params[:adv_search].nil? or params[:adv_search].eql?('')
				query.keywords params[:adv_search], :fields => fields, :highlight => true
				query.paginate :page => params[:page], :per_page => @per_page
				# Query facet setting
				query.facet(:author)
				query.facet(:document_type_id)
				query.facet(:department)
				query.facet(:defense_year)
				query.facet(:release_year)
				query.facet(:file_type)
				# Query delimiters
				query.with(:availability_status).any_of(patron_availabilities) if !isUserAdmin
				query.with(:author, params[:author]) if params[:author].present?
				query.with(:urn, params[:urn]) if params[:urn].present?
				query.with(:defense_date).less_than(stripDate(params[:defense_date_before])) if params[:defense_date_before].present?
				query.with(:defense_date).greater_than(stripDate(params[:defense_date_after])) if params[:defense_date_after].present?
				query.with(:release_date).less_than(stripDate(params[:release_date_before])) if params[:release_date_before].present?
				query.with(:release_date).greater_than(stripDate(params[:release_date_after])) if params[:release_date_after].present?
				if params[:doc_info].present? 
					if params[:doc_info][:department].present?
						query.with(:department).all_of(params[:doc_info][:department])
					end

					if params[:doc_info][:document_type_id].present?
						query.with(:document_type_id, params[:doc_info][:document_type_id])
					end

					if params[:doc_info][:defense_year].present?
						query.with(:defense_year, params[:doc_info][:defense_year])
					end

					if params[:doc_info][:release_year].present?
						query.with(:release_year, params[:doc_info][:release_year])
					end

					if params[:doc_info][:file_type].present?
						query.with(:file_type, params[:doc_info][:file_type])
					end
				end
				if params[:type_etd].present? ^ params[:type_btd].present?
					params[:type_etd].present? ? query.with(:bound, false) : query.with(:bound, true)
				end
			end

			if @search.results.size < 1 
				@result = "none_found"
			else
				@result = @search.results
				@results_info = "Showing Results #{@result.offset + 1} - 
								#{@result.size + @result.offset} of #{@search.total}" 
			end
		rescue Exception => ex
			# Catch exceptions, likely due to solr server being down
			@result = "exception"
			@exception_message = ex.message
		end
	end

	private
	def stripDate(dateString)
		if !dateString.nil?
			arr = dateString.split("-")

			arr.each do |i|
				if !isInt(i)
					raise "Please Check Your Dates"
				end
			end

			case arr.length
			when 1
				return Date.strptime(dateString, '%Y')
			when 2
				return Date.strptime(dateString, '%Y-%m')
			when 3
				return Date.strptime(dateString, '%Y-%m-%d')
			else
				raise "Please Check Your Dates"
			end
		end
	end

	private
	def isInt(strToMatch)
		if strToMatch =~ /^\d+$/
			return true
		else
			return false
		end
	end

	private
	def isUserAdmin
		return !current_person.roles.where(group: 'Administration').empty?
	end
	helper_method :isUserAdmin
end
