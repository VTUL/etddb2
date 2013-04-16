module Pagination_Helper

	def sanitize_per_page(per_page)
		if isInt(per_page)
			return per_page
		else
			return 10
		end
	end

	def isInt(strToMatch) 
		if strToMatch =~ /^\d+$/
			return true
		else
			return false
		end
	end

	module_function :sanitize_per_page
	module_function :isInt
end