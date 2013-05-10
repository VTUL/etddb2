var containingName = "doc_info";
var timer;

$(document).ready(function () {
	/** 
	 *	On page load attach a listener to ensure the correct label
	 *  is placed on the selections button
	 */
	$(".option_checks").on("change", function() {
		setSelectionButtonName();
    });

	$(".date_range_input").keyup(function() {
		clearTimeout(timer);
		timer = setTimeout(checkDateRanges, 750);
	});

	// Perform an initial check
    setSelectionButtonName();
});

/**
 *	Called from advanced search form
 */
function set_selections() {
	// All checked boxes for advanced search
	$checks = $(".option_checks").filter(":checked");
	if ($checks.length < 1) {
		// Reset all checkboxes to true
		$(".option_checks").each(function() {
			$(this).prop("checked", true);
		});
		$("#clear_button").html('Clear Selections');
	} else {
		// Uncheck all boxes
		$checks.each(function() {
			$(this).prop("checked", false);
		});
		$("#clear_button").html('Select All');
	}
}

function setSelectionButtonName() {
	// All checked boxes for advanced search
	$checks = $(".option_checks").filter(":checked");
    if ($checks.length < 1) {
    	// No checkboxes checked
    	$("#clear_button").html('Select All');
    } else {
    	// Selctions can be cleared
    	$("#clear_button").html('Clear Selections');
    }
}

function checkDateRanges() {
	$flag = true;
	$(".date_range_input").each(function() {
		// Input has text
		if ($(this).val().length > 0) {
			// If invalid show the formatting prompt
			if (!isValidDate($(this).val())) {
				$('#date_format').slideDown('fast');
				$('#date_format').css("display", "inline-block");
				$flag = false;
				return false;
			}
		}
	});
	// If no invalid dates are found remove the prompt
	if ($flag) $('#date_format').slideUp('fast');
}

function isValidDate($dateStr) {
	// Match 4 integers in a row
	$yearReg = /^\d{4}$/;
	// Match 2 integers in a row
	$monReg = /^\d{2}$/;

	switch ($dateStr.length) {
		// Case for a year only
		case 4:
			return $yearReg.test($dateStr);
		// Year and month
		case 7:
			$split = $dateStr.split("-");
			if ($split.length == 2) {
				return ($yearReg.test($split[0]) && $monReg.test($split[1]))
			}
			break;
		// Year, month, and day
		case 10:
			$split = $dateStr.split("-");
			if ($split.length == 3) {
				return ($yearReg.test($split[0]) && $monReg.test($split[1])
												 && $monReg.test($split[2]))
			}
			break;
		default:
			return false;
	}
	return false;
}

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
	if ($dropdowns.length > 0) {
		$dropdowns.each(function() {
			var $name = getName(containingName, $(this).attr("name"));
			if($name != -1 && $name != "department")
				appendWithValue($(this));
		});
	} else {
		// Page contains no dropdowns, look for faceted_if_no_dropdown class
		$absentDropdownFacets = $(".faceted_if_no_dropdown");
		$absentDropdownFacets.each(function() {
			appendWithManualID($(this));
		});
	}

	/** 
	 *  Add in facets or objects that can have multiple selections
	 *  To use add "multi_selectable" as the element's class and the 
	 *  id as that element's value.  Element name functions the same as other
	 *  input types
	 */
	$multi_selectables = $(".multi_selectable");
	$multi_selectables.each(function() {
		appendWithManualID($(this));
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

function appendWithManualID($value) {
	var generatedID = containingName + getName(containingName, $value.attr("name")) + "_";
	$('<input type="hidden" value="' + $value.attr("id") + '" name="' + $value.attr("name") + '"' 
			+ ' id="' + generatedID + '" class="pref_removable">').appendTo('#page_pref_form');
}