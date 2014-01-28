class NodeStatus < ActiveRecord::Base
  after_save :create_history_entry

  attr_accessible :fw_version, :initial_conf_version, :node_id, :vpn_status_id, :vpn_sw_name,:ip, :viewpoint, :vpn_status
  belongs_to :node
  belongs_to :vpn_status
  belongs_to :viewpoint

  private
  
  def create_history_entry
    # Expire old history entries
    NodeStatusHistory.where("node_id = ? and expired_at is null and id <> ? and viewpoint = ?",self.node_id,self.id,self.viewpoint).each do |status|
      status.update_attribute(:expired_at, DateTime.now)
    end
    # Create a new Historic entry based on the current one.
    NodeStatusHistory.create!(
      fw_version: self.fw_version,
      initial_conf_version: self.initial_conf_version,
      node_id: self.node_id,
      vpn_status_id: self.vpn_status_id,
      vpn_sw_name: self.vpn_sw_name,
      viewpoint: self.viewpoint,
      vpn_status: self.vpn_status
    )
  end
end
