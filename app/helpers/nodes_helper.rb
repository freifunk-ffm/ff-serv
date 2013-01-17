module NodesHelper

  def ping_image_url(node)
    url = 'https://kbu.freifunk.net/stats/ping/'
    if(node.status.vpn_sw_name == "tinc")
      url += 'ping_to_node-' + node.link_local_address
    else
      url += "ping_to_fastd_node-" + node.link_local_address_short
    end
    url += "_hour.png"
  end

  def thruput_image_url(node)
    url = "http://kbu.freifunk.net/stats/nodes_traffic/#{node.mac}_day.png"
  end
end
