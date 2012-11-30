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
def update_node_status(argv,vpn_status)
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
  node = Node.find_or_create_by_mac(node_str)
  node.update_vpn_status(vpn_status,ip,vpn_sw)
end
