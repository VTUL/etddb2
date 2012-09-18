// var field = $('<input id="business_loc" multiple="multiple" name="search_using" type="hidden" style="color: rgb(175, 175, 175); " value="13.0454044">');
// var form = $('page_pref_form');
// form.append(field);

function submit_form() {
	//Grab paginate selection form
	var $form = $('#page_pref_form :hidden');
	
	$form.each(function() {
		//Get titles for variables
		var inputName = $(this).attr("name");
		if (inputName.indexOf("search_using") >= 0) {
			var start = inputName.indexOf("[");
			var end = inputName.indexOf("]");

			if (start < 0 || end < 0) return true;
			alert(inputName.slice(start + 1, end));
		}
	});

	//Put titles into list, cross reference with currently selected checkboxes, add/remove as necessary, submit form

	$("#page_pref_form").submit();
}


	// $('[id^=search_using_]').live('change', function(){
	// 	var $form = $('page_pref_form :input');

	// 	$form.each(function() {
	//         	alert("");
	//         });
	//     if($(this).is(':checked')){
	//         $form.each(function() {
	//         	alert("");
	//         });
	//     } else {
	//         alert('un-checked');
	//     }
	// });