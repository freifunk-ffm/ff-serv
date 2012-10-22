### IMPORTANT: IT IS ASSUMED THAT 'node' IS PARSED AS A COMMAND LINE PARAMETER - CORRECTLY ESCAPED!
### MAKE SURE, THAT VALID NODE MACS ARE ACCEPPTED, ONLY -> see: ApplicationController::authenticate_mac


task :node_up, [:argument] => :environment do |task, args|
  status = VpnStatus.where(:name => "up").first
  update_node_status(ARGV,status)
end

task :node_down, [:argument] => :environment do |task, args|
  status = VpnStatus.where(:name => "down").first
  update_node_status(ARGV,status)
end

private
def update_node_status(argv,status)
  args = {}
  argv.each do |arg|
    key = arg.split('=').first.to_sym
    val = arg.split('=').last
    args[key] = val
  end
  
  node_str = args[:node]
  ip_str = args[:ip]
  vpn_sw_str = args[:vpn_sw]
  
  # Sanity check
  raise "No node given" if node_str.blank?
  node = Node.where(:mac => node_str).first
  return if(node.nil?) #If node is not in DB -> don't care. Hosts like vpn1.kbu.freifunk.net are missing

  Node.transaction do
    old_status = node.status
    NodeStatus.create(
     :fw_version => old_status.fw_version,
     :initial_conf_version => old_status.initial_conf_version,
     :node_id => node.id,
     :vpn_status_id => status.id,
     :vpn_sw_name => vpn_sw_str,
     :ip => ip_str)
  end
end