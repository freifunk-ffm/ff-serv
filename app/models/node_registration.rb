class NodeRegistration < ActiveRecord::Base
  using_access_control
  
  attr_accessible :latitude, :loc_str, :longitude, :name, :operator_email, :operator_name, :notice, :osm_loc, :node_at
  has_one :node
  belongs_to :owner, :class_name => "User"
  belongs_to :creator, :class_name => "User", :foreign_key => 'created_by'
  belongs_to :updater, :class_name => "User", :foreign_key => 'updated_by'

  def node_at=(attrs)
    self.node = Node.find(attrs[:id])
  end
end
