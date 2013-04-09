class Node < ActiveRecord::Base
  require 'netaddr'
  require 'net/http'
  using_access_control
  validates_format_of :mac, :with => /^[0-9a-f]{12}$/i
  
  attr_accessible :mac, :registration_id
  has_many :fastds
  has_many :node_statuses
  has_many :tincs
  has_one  :valid_tinc, :conditions => 'approved_at IS NOT NULL and revoked_at IS NULL', :class_name => 'Tinc'
  belongs_to :node_registration
  has_one :status, :conditions => "expired_at IS NULL", :class_name => 'NodeStatus', :include => ['vpn_status']
  
  scope :registered, where('node_registration_id IS NOT NULL').includes([:status]) 
  scope :unregistered, where("node_registration_id IS NULL").includes([:status])  
  scope :reg_able, unregistered.with_permissions_to(:register)
  
  scope :online, joins(:status).where(:node_statuses => {:vpn_status_id => VpnStatus.UP.id})

  after_create :add_mac_to_stat
  
  def add_mac_to_stat
    uri = URI('http://collectd.kbu.freifunk.net/nodes/add_macs')
    res = Net::HTTP.post_form(uri, 'mac' => [mac])
    puts res.body
  end

  def self.unregistered_home(ip_address) 
    Node.unregistered.joins([:status]).where(:node_statuses => 
      {:ip => ip_address}
    )
  end
  
  def update_vpn_status(vpn_status,ip,vpn_sw)
    ip_str = "#{ip}"
    vpn_sw_str = "#{vpn_sw}"
    Node.transaction do
      old_status = self.status || NodeStatus.new
      NodeStatus.create(
       :fw_version => old_status.fw_version,
       :initial_conf_version => old_status.initial_conf_version,
       :node_id => self.id,
       :vpn_status_id => vpn_status.id,
       :vpn_sw_name => vpn_sw_str,
       :ip => ip_str)
    end
  end
  
  def fw_version
    if fastds.size > 1 
      fastds.order("updated_at ASC").first.fw_version
    elsif status && status.vpn_sw_name == 'fastd'
      "1.0"
    else
      "< 1.0"
    end
  end
  
  # No leading 0 in groups
  def link_local_address_short
    bs = self.mac.scan(/../).join(':')
    addr = NetAddr::EUI.create(bs)
    addr.link_local(:Short => true)
  end
  
  def link_local_address
    bs = self.mac.scan(/../).map {|c| c.to_i(16)}
    #Flip universal bit (6-th) bit of first octet - count from beginning
    bs[0] ^= 2
    b = bs.map {|bm| "%02x" % bm}
    return unless b.size == 6 #Hack for broken numbers
    first = b[0] + b[1]
    second = b[2] + "ff"
    third = "fe" + b[3]
    fourth = b[4] + b[5]
    "fe80::" + [first,second,third,fourth].join(':')
  end
end
