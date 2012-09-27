function init_reg_map(element_id){
	var map = L.map(element_id).setView([51.505, -0.09], 13);
	var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
	
	L.tileLayer(osmUrl, {
	    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
	}).addTo(map);

}
