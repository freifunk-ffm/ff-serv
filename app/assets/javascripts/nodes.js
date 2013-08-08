function init_node_map(nodes_map, lat, lng){
	var zoom = 10
	var map = L.map(nodes_map,{scrollWheelZoom: false}).setView([lat, lng], zoom);
	L.marker([lat,lng],{icon: assetIcon}).addTo(map);
	
	var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
	L.tileLayer(osmUrl, {
	    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a></a>',
	}).addTo(map);
	
}
