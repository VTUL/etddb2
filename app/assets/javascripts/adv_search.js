function submit_form() {
	var $currChecked = new Array();

	// Remove all inputs from page pref dropdown
	$('.pref_removable').remove();
	
	// Strip title from all checked boxes, add to list
	$checkBoxForm = $("#search_check_form :checked");
	$checkBoxForm.each(function() {
		var $parsed = getName("search_using", $(this).attr("name"));
		if ($parsed != -1)
			$currChecked.push($parsed);
	});

	// Add back in those that were selected 
	for(var i = 0; i < $currChecked.length; i++) {
		$('<input type="hidden" value="1" name="search_using[' + $currChecked[i] + ']"' 
			+ ' id="search_using_' + $currChecked[i] + '" class="pref_removable">').appendTo('#page_pref_form');
	}

	// Submit form
	$("#page_pref_form").submit();
}

//If string contains the keyword, extract anything between '[' and ']'
//Returns -1 on failure
function getName($keyword , $rawString) {
	if ($rawString.indexOf($keyword) >= 0) {
		var start = $rawString.indexOf("[");
		var end = $rawString.indexOf("]");

		if (start < 0 || end < 0) return -1;
		return $rawString.slice(start + 1, end);
	}
	return -1;
}