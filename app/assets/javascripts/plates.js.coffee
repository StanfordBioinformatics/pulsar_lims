# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ -> 
	#set the failed wells to red. The .failure class is set on wells where the 'fail' attribute is set to true, and this class
	# is added in the Plate show view. 
	$("td:has(a.failure)").css({"background-color":"red"})
	$("a.failure").css({"color":"black"})

