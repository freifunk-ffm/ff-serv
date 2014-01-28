module NodesHelper

  def ping_image_url(node)
    url = 'https://kbu.freifunk.net/stats/ping/'
    if(node.fw_version == "< 1.0")
      url += 'ping_to_node-' + node.link_local_address + "_hour.png"
    else
      #http://stat.kbu.freifunk.net/nodes/159387616943362/stats/ping.png?secs=3600&width=400&height=160&no_summary=1
      url = "http://stat.kbu.freifunk.net/nodes/#{node.mac.to_i(16)}/stats/ping.png?secs=3600&width=400&height=160&no_summary=2"
    end
  end

  def thruput_image_url(node,interface)
    url = "http://stat.kbu.freifunk.net/nodes/#{node.mac.to_i(16)}/stats/interface/octets-#{interface}.png?secs=3600&width=400&height=160&no_summary=2"
  end
end
