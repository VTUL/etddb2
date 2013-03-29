module Pagination_Helper

	def isInt(strToMatch)
		if strToMatch =~ /^\d+$/
			return true
		else
			return false
		end
	end

	def sanitize_per_page(per_page)
		return isInt(per_page) ? per_page : per_page = 10
	end

	module_function :sanitize_per_page
end