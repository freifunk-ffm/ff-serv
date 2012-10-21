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

  def self.unregistered_home 
    Node.unregistered.joins([:status]).where(:node_statuses => 
      {:ip => Authorization.current_user.current_sign_in_ip}
    )
  end
end
