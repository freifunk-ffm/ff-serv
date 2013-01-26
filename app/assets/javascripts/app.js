const nodes_map = 'nodes_map'
function init_nodes_map(){
	var lat = 50.82990 // At Wesseling
	var lng = 6.988334655761719
	var zoom = 10

	var map = L.map(nodes_map).setView([lat, lng], zoom);

	map.setView([lat, lng], zoom);
	
	var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
	L.tileLayer(osmUrl, {
	    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
	}).addTo(map);

	// Load nodes
	$.getJSON('/nodes.json', function(data) {
	  $.each(data, function(key, val) {
		var status = val.status
		var node = val.node
		var reg = val.node_registration
		var vpn_status = val.vpn_status.name
		if(!(reg.latitude===null || reg.longitude===null)){
			var marker = L.marker([reg.latitude,reg.longitude],{icon: assetIcon}).addTo(map);
			marker.bindPopup("<b><a href='/node_registrations/"+reg.id+"/edit'>" + reg.name + "</a></b><br />"+
				"<a href='/node_statuses?node="+node.id+"'>VPN-Status</a>: <span class='vpn_status"+vpn_status+"' >"+vpn_status + "</span>" + 
				"<br />Node-ID: <span class='monospaced'>"+node.mac+"</span> <br />"+
				"Letzte &Auml;nderung: " + status.created_at).openPopup()
		}
	 });
	})
}
