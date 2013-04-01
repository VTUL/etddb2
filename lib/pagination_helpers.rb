module Pagination_Helper

	def sanitize_per_page(per_page)
		if per_page =~ /^\d+$/
			return per_page
		else
			return 10
		end
	end

	module_function :sanitize_per_page
end