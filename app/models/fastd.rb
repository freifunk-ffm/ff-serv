class Fastd < ActiveRecord::Base
  attr_accessible :fw_version, :key, :node_id
  belongs_to :node
end
