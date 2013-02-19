function submit_form() {
	// Remove all inputs from page pref dropdown
	$('.pref_removable').remove();
	
	// Strip title from all checked boxes, add to list
	$checkBoxForm = $("#search_check_form :checked");
	$checkBoxForm.each(function() {
		if ($(this).attr("name") != undefined)
			appendWithValue($(this));
	});

	// Add dropdown values to form before submitting page pref
	$dropdowns = $("select.dropdowns");
	$dropdowns.each(function() {
		var $name = getName("doc_info", $(this).attr("name"));
		if($name != -1)
			appendWithValue($(this));
	});

	// All facets that aren't included in dropdowns
	$facets = $(".faceted");
	$facets.each(function() {
		appendWithText($(this));
	});

	// Add the date range inputs
	$date_ranges = $(".date_range_input");
	$date_ranges.each(function() {
		appendWithValue($(this));
	});

	// Submit form
	$("#page_pref_form").submit();
}

//If string contains the keyword, extract anything between '[' and ']'
//Returns -1 on failure
function getName($keyword , $rawString) {
	if ($keyword == undefined || $rawString == undefined) return -1;
	if ($rawString.indexOf($keyword) >= 0) {
		var start = $rawString.indexOf("[");
		var end = $rawString.indexOf("]");

		if (start < 0 || end < 0) return -1;
		return $rawString.slice(start + 1, end);
	}
	return -1;
}

function appendWithValue($value) {
	$('<input type="hidden" value="' + $value.val() + '" name="' + $value.attr("name") + '"' 
			+ ' id="' + $value.attr("id") + '" class="pref_removable">').appendTo('#page_pref_form');
}

function appendWithText($value) {
	$('<input type="hidden" value="' + $value.text() + '" name="' + $value.attr("name") + '"' 
			+ ' id="' + $value.attr("id") + '" class="pref_removable">').appendTo('#page_pref_form');
}