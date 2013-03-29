module Pagination_Helper
	def sanitize_per_page(per_page)
		if per_page =~ /^\d+$/
	      sanitized = per_page
	    else
	      sanitized = 10
	    end

	    return sanitized
	end

	module_function :sanitize_per_page
end