// Clear search query
function clearooouery(id,text) {
 if(!document.getElementById(id)) return false;
 if (document.getElementById(id).value == text) {
	document.getElementById(id).value = "";
 }


// Create first and last list classes

function  firstLastList() {
	if(!document.getElementsByTagName) return false;

	var ul = document.getElementsByTagName("ul");

	for (var i = 0; i < ul.length; i++ )
	{
		var li = ul[i].getElementsByTagName("li");
		if (!li.length) continue;
		li[0].className += " first";
		li[li.length-1].className += " last";
	}

	var ol = document.getElementsByTagName("ol");

	for (var i = 0; i < ol.length; i++ )
	{
		var li = ol[i].getElementsByTagName("li");
		if (!li.length) continue;
		li[0].className += " first";
		li[li.length-1].className += " last";
	}
}

// Open links in a new window

function openWindow() {
	if (!document.getElementsByTagName) return false;
	
	var links = document.getElementsByTagName("a");
	
	for ( var i = 0; i < links.length; i++ )
	{
		if (links[i].className.search(/open-window/) != -1)
		{
			links[i].onclick = function() {
				if(!document.getElementById) return true;
				//open a new window with the anchors url
				window.open(this.getAttribute("href"));
				return false;
			}
		}
	}
}

// Stripe tables

// This function is need to work around 
// a bug in IE related to element attributes
function hasClass(obj) {
	
	var result = false;
	
	if (obj.getAttributeNode("class") != null) {
		result = obj.getAttributeNode("class").value;
		}
		return result;
		} 


// Choose search criteria

function assignURL()  {
   for( i = 0; i < document.vtsearchform.url.length;i++)    {
   if( document.vtsearchform.url[ i ].checked ) document.vtsearchform.action =  document.vtsearchform.url[ i ].value;
	  document.vtsearchform.submit();
	  }
   }


// Test for clear search query
function clearText(field){
    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;
}


// Submit search form

function submitForm(formId) {
	document.getElementById(formId).submit();
}

// Event handlers

function addLoadEvent(func) {
	var oldOnLoad = window.onload
	if (typeof window.onload != 'function') 
	{
		window.onload = func;
	}
	else {
		window.onload = function() {
			oldOnLoad();
			func();
		}
	}
}

addLoadEvent(firstLastList);
addLoadEvent(openWindow);
