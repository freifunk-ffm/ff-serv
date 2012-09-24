class NodeRegistration < ActiveRecord::Base
  attr_accessible :latitude, :loc_str, :longitude, :name, :operator_email, :operator_name, :notice, :osm_loc, :node_attrs
  has_one :node
  belongs_to :owner, :class_name => "User"
  belongs_to :creator, :class_name => "User", :foreign_key => 'created_by'
  belongs_to :updater, :class_name => "User", :foreign_key => 'updated_by'

  def node_attrs=(attrs)
    node = Node.new
  end
end
