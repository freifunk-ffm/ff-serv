module NodesHelper

  def ping_image_url(node)
    url = 'http://kbu.freifunk.net/stats/ping/'
    if(node.status.vpn_sw_name == "tinc")
      url += 'ping_to_node-'
    else
      url += "ping_to_fastd_node-"
    end
    url += node.link_local_address + "_hour.png"
  end
end
