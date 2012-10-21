class Tinc < ActiveRecord::Base
  attr_accessible :cert_data, :certfp, :ip_address, :node_id
  belongs_to :node
  
  #Is the cert-fingerprint / node combination known and not revoked?
  def self.cert_fp_node_known?(cert_fp,node_id)
    num = Tinc.where("node_id = ? and certfp = ? and revoked_at is null",node_id,cert_fp).count
    num == 1
  end

  ## Approve key without interaction
  def auto_approve!
    update_attribute(:approved_at,DateTime.now)
    update_attribute(:approved_by, User.APPLICATION)
    write_key!
  end

  # Is there an ongoing collision for that node?
  def self.collision_for_node?(node_id)
    num = Tinc.where("node_id = ? and revoked_at is null",node_id).count
    num > 1
  end

  # Revoke Tinc submission
  def revoke!
    unless (self.revoked_at.present?)
      self.revoked_at = DateTime.now
      self.revoked_by = Authorization.current_user.id
      save!
    end
  end

  def approve!
    self.approved_at = DateTime.now
    self.revoked_by = Authorization.current_user.id
    Tinc.where("node_id = ? and id <> ? and revoked_at is null",node.id,id).each do |tinc|
      tinc.revoke!
    end
    save!
    write_key!
  end

  # Write key to file system
  def write_key!
    dir = Tinc.config['key_dir']
    File.open("#{dir}/#{node.mac}", 'w') do |f|
      f.write(self.cert_data) 
    end
  end

  def can_approve?
    self.approved_at.nil? && self.revoked_at.nil?
  end

  def can_revoke?
    self.approved_at.nil? && self.revoked_at.nil?
  end

  private
  def self.config
    @@tinc_config ||= YAML::load_file("#{Rails.root}/config/tinc.yml")
  end


end
