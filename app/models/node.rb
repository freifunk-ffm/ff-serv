class Node < ActiveRecord::Base
  using_access_control
  
  attr_accessible :mac, :registration_id
  
  has_many :node_statuses
  has_many :tincs
  has_one  :valid_tinc, :conditions => 'approved_at IS NOT NULL and revoked_at IS NULL', :class_name => 'Tinc'
  belongs_to :node_registration
  has_one :status, :conditions => "expired_at IS NULL", :class_name => 'NodeStatus', :include => ['vpn_status']
  
  scope :registered, where('node_registration_id IS NOT NULL').includes([:status]) 
  scope :unregistered, where("node_registration_id IS NULL").includes([:status])  
  scope :reg_able, unregistered.with_permissions_to(:register)


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
  
end
