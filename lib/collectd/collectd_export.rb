require 'erb'

class CollectdExport

  def self.persist_ping_hosts(addrs)
    addresses = addrs
    result = CollectdExport.template.result(binding)
    File.open(config['ping_host_file'], "w", 0644) do |file|
      file.flock File::LOCK_EX
      file.write result
    end
    
    
  end
  
  private
  def self.config
    @@config ||= YAML::load_file("#{Rails.root}/config/collectd.yml")
  end

  def self.reload
    system(config['reload_command'])
  end
  
  def self.template
    @@template ||= ERB.new(File.open("#{Rails.root}/config/collectd_ping_hosts.conf.erb", "r").read)
  end
  
end