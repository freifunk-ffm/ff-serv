class VpnStatus < ActiveRecord::Base
  attr_accessible :name
  def to_s
    "#{name}"
  end
  
  def self.UNKOWN
    @@unknown ||= VpnStatus.find_or_create_by_name('unknown')
  end
  
  def self.UP
    @@up ||= VpnStatus.find_or_create_by_name('up')
  end

  def self.DOWN
    @@down ||= VpnStatus.find_or_create_by_name('down')
  end
  


end
