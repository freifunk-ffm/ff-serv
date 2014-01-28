class NodeStatusHistory < ActiveRecord::Base
  attr_accessible :fw_version, :initial_conf_version, :ip, :node_id, :viewpoint_id, :vpn_status_id, :vpn_sw_name
  belongs_to :node
  belongs_to :vpn_status
  belongs_to :viewpoint
end
