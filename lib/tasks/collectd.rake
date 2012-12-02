task :create_ping_list, [:argument] => :environment do |task, args|
  addrs = Node.all.map {|n| n.link_local_address}
  CollectdExport.persist_ping_hosts(addrs)
end
