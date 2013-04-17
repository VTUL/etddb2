require 'test_helper'

class PaginationHelperTest < ActiveSupport::TestCase

	# isInt tests
	test "valid with integer given" do
		assert Pagination_Helper.isInt('3')
		assert Pagination_Helper.isInt('100')
		assert Pagination_Helper.isInt('3000')
	end

	test "invalid with non-numeric characters" do
		assert !Pagination_Helper.isInt('3a')
		assert !Pagination_Helper.isInt('red')
		assert !Pagination_Helper.isInt('3,000')
		assert !Pagination_Helper.isInt('3.14')
	end

	test "invalid with non string" do
		assert_raise RuntimeError do
			Pagination_Helper.isInt(3)
		end

		assert_raise RuntimeError do
			x = Hash.new
			Pagination_Helper.isInt(x)
		end
	end

	test "invlaid with nil" do
		assert !Pagination_Helper.isInt(nil)
	end

	# sanitize_per_page tests
	test "returns given value if valid" do
		assert_equal '7', Pagination_Helper.sanitize_per_page('7')
		assert_equal '700', Pagination_Helper.sanitize_per_page('700')
		assert_equal '46', Pagination_Helper.sanitize_per_page('46')
	end

	test "returns 10 if invalid" do
		assert_equal 10, Pagination_Helper.sanitize_per_page('3.0')
		assert_equal 10, Pagination_Helper.sanitize_per_page('e')
		assert_equal 10, Pagination_Helper.sanitize_per_page('340F')
		assert_equal 10, Pagination_Helper.sanitize_per_page('50%')
	end
end