class CollectdExport

  def self.persist_ping_hosts(addresses)
    iface = config['ping_interface']
    File.open(config['ping_host_file'], "w", 0644) do |file|
      file.flock File::LOCK_EX
      addresses.each do |addr|
        file.write "Host: \"#{addr}%#{iface}\"\n"
      end
    end
    
    
  end
  
  private
  def self.config
    @@config ||= YAML::load_file("#{Rails.root}/config/collectd.yml")
  end

  def self.reload
    system(config['reload_command'])
  end
  
end