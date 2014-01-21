const nodes_map = 'nodes_map'
var msg_shown = false;
function init_nodes_map(){
	var lat = 50.82990 // At Wesseling
	var lng = 6.988334655761719
	var zoom = 9 

	var map = L.map(nodes_map).setView([lat, lng], zoom);

	map.setView([lat, lng], zoom);
	
	var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
	L.tileLayer(osmUrl, {
	    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
	}).addTo(map);

	
	// Load nodes
	$.getJSON('/nodes.json', function(data) {
		var markers = {}
	  	$.each(data, function(key, val) {
			var id_hex = val.node.mac_dec
			var reg = val.node_registration
			if(reg.latitude && reg.longitude){
				var marker = L.marker([reg.latitude,reg.longitude],{icon: assetIcon}).addTo(map)
				marker.bindPopup(wrap_marker_span(popup_text(val,null),id_hex)).openPopup() // Since leaflet itself is unable to update its markers
																					  // We'll will update the content by refering to its span
				markers[id_hex] = {node: val, l_marker: marker}
			}
		});
		// Referesh 15 secs. (ping interval of collectd.kbu.freifunk.net)
		update_node_status(markers);
		setInterval(function(){
			update_node_status(markers)
		},15000);
	}).error(function(jqXHR,error, errorThrown) {  
	      	alert("Unable to get nodes: " + error + ": " + errorThrown) 
		})
}

// Hack for updating markers
function wrap_marker_span(str,id_hex){
	return "<span class='map_popup' id='popup_text_"+id_hex+"'>" + str + "</span>"
}
function update_node_status(markers){
	$.getJSON('http://stat.kbu.freifunk.net/nodes.json', function(data) {
		$.each(data, function(key, val) {
			if(markers[key]){
				var node = markers[key].node
				var marker = markers[key].l_marker
				var text = popup_text(node,val)
				$('#popup_text_'+key).html(text) //Since this get lost, while reopen the marker, rebind the popup as well
				marker.bindPopup(wrap_marker_span(text,key))
			}
			
		})
	}).error(function(xhr,error, errorThrown) {  
      	if(xhr.status == 0 && !msg_shown){
      		alert("Der Browser erlaubt nicht das Nachladen der Node-Statistiken - Ggf. verhindert NoScript den CORS-Request");
      		msg_shown = true;
      	}else{
	      	alert("Fehler": + xhr.status + " - " + errorThrown);
      	}
	})
}

function popup_text(node_json,node_status_json){
	var node = node_json.node
	var vpn_status = node_json.vpn_status
	var reg = node_json.node_registration
	var id_hex = node_json.id_hex
	var status_str = ""
	var ping_str = ""
	if(node_status_json && node_status_json.rtt_5_min){
		var rtt = Math.round(node_status_json.rtt_5_min)
		var loss = node_status_json.loss_5_min
		var grade = grade_node_status(rtt,loss)
		status_str = "Erreichbarkeit: "+grade_string(grade) + "<br />"
		ping_str = "Ping: " + rtt + "ms - Verlust: " + Math.round(loss*100) + "%<br />"
		
	}
	// Element
	var registration_link_elem = "<a href='/node_registrations/"+reg.id+"/edit'>" + reg.name + "</a><br />"
	var vpn_status_elem = "VPN-Status: <span class='vpn_status"+vpn_status+"' >"+vpn_status + "</span></br />"
	var node_id_elem = "Node-ID: <span class='monospaced'>"+node.mac+"</span><br />"
	return registration_link_elem + status_str + vpn_status_elem + node_id_elem + ping_str

}


// School grades for nodes
function grade_node_status(rtt,loss){
	var grade = -1
	if(rtt < 100 && loss < 0.01){
		grade = 1
	} else if (rtt < 150 && loss < 0.02){
		grade = 2
	} else if (rtt < 200 && loss < 0.04) {
		grade = 3
	} else if (rtt < 300 && loss < 0.08) {
		grade = 4
	} else if (loss < 0.9){
		grade = 5
	} else if(loss > 0.9) {
		grade = 6
	}
	return grade;
}

// Translate grades to readable html elements
function grade_string(grade){
	var grade_strs = {
		1: "<span class='grade_1'>Sehr gut</span>",
		2: "<span class='grade_2'>Gut</span>",
		3: "<span class='grade_3'>Befriedigend</span>",
		4: "<span class='grade_4'>Ausreichend</span>",
		5: "<span class='grade_5'>Mangelhaft</span>",
		6: "<span class='grade_6'>Ungen&uuml;gend / Offline</span>"
	}
	return grade_strs[grade]
}
