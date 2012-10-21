class NodeStatus < ActiveRecord::Base
  after_create :expire_old
  
  attr_accessible :fw_version, :initial_conf_version, :node_id, :vpn_status_id, :vpn_sw_name,:ip
  belongs_to :node
  belongs_to :vpn_status
  
  private
  
  def expire_old
    NodeStatus.where("node_id = ? and expired_at is null and id <> ?",self.node_id,self.id).each do |status|
      status.update_attribute(:expired_at, DateTime.now)
    end
  end
end
