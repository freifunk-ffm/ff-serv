# encoding: UTF-8
require 'crypt/rot13'

class NodeRegistration < ActiveRecord::Base
  include Crypt
  before_create :save_node
  using_access_control
  
  validates_presence_of :operator_name
  validates_presence_of :operator_email
  validates_presence_of :name
  
  validates_format_of :operator_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "ist keine gültige E-Mail-Adresse"


  attr_accessible :latitude, :loc_str, :longitude, :name, :operator_email, :operator_name, :notice, :osm_loc, :node_at
  belongs_to :node
  belongs_to :owner, :class_name => "User"
  belongs_to :creator, :class_name => "User", :foreign_key => 'created_by'
  belongs_to :updater, :class_name => "User", :foreign_key => 'updated_by'

  def node_at=(attrs)
    self.node = Node.find_by_id(attrs[:id]) || Node.new(id: attrs[:id])
  end

  def operator_emaiL_rot13
    Rot13.new("#{operator_emaiL}", 13)
  end

  private
  def save_node
    self.node.save!
  end
end
