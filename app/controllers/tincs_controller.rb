# encoding: UTF-8

class TincsController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]
  before_filter :authenticate_mac, :only => [:create]
  filter_access_to :show, :approve, :revoke
  
  # GET /tincs
  # GET /tincs.json
  def index
    node_id = params[:n]
    node_ids = Node.with_permissions_to(:register).map{ |n| n.id}
    @tincs = Tinc.where("node_id IN (?)",node_ids).includes(:node)
    if (node_id)
      @tincs = @tincs.where({:node_id => node_id})
      @node = Node.find(node_id)
    end
    @warn_collision = Tinc.collision_for_node?(node_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tincs }
    end
  end

  # GET /tincs/1
  # GET /tincs/1.json
  def show
    @tinc = Tinc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tinc }
    end
  end

  # POST /tincs
  # POST /tincs.json
  def create
    cert_data = params[:cert].read
    if cert_data.blank?
      render :status => :unprocessable_entity, :text => "Certificate missing in request"
    else 
      Tinc.transaction do 
        node = Node.find_or_create_by_mac(session[:wlan_mac])
        if node.status.blank?
          status = NodeStatus.create(:node_id => node.id, 
            :vpn_status_id => VpnStatus.DOWN.id, 
            :vpn_sw_name => "tinc",
            :ip => request.remote_ip,
            :fw_version => params[:fw_version],
            :initial_conf_version => params[:initial_conf_version])
        end
        
        cert_fp = Digest::SHA1.hexdigest(cert_data)
        # Re-Submit of known cert ?
        if Tinc.cert_fp_node_known?(cert_fp,node.id)
          node.valid_tinc.update_attribute(:updated_at,DateTime.now)
          render :status => :not_modified, :text => "Certificate already processed"
        else #Unknown / new certificate
          tinc = Tinc.create(:certfp => cert_fp,:node_id => node.id, 
              :ip_address => request.remote_ip,:cert_data => cert_data) # Create DB-Entry
            if node.valid_tinc.present? #Another certificate is valid for this node
              notify_admins_on_collision(node)
              notify_owner_on_collision(node)
              render :status => :accepted, :text => "Request accepted - owner will be notified"
            else
              ## Approve and notify
              tinc.auto_approve!
              notify_admins_on_new_node(node)
              render :status => :created, :text => "Request sucessful"
            end
        end
      end
    end
  end
  
  def approve
    Tinc.find(params[:id]).approve!
    redirect_to :back, notice: 'Tinc-Schlüssel akzeptiert'
  end
  
  def revoke
    Tinc.find(params[:id]).revoke!
    redirect_to :back, notice: 'Tinc-Schlüssel verworfen'
  end
  
  private
  
  def notify_admins_on_new_node(node)
    #Thread.new do
      Role.ADMIN.users.each do |user|
        TincMailer.new_approved_email(user,node).deliver
      end
    #end
  end
  
  def notify_admins_on_collision(node)
    #Thread.new do
      Role.ADMIN.users.each do |user|
        TincMailer.collision_info(user,node).deliver
      end
    #end
  end

  def notify_owner_on_collision(node)
    reg = node.node_registration
    if reg.present?
     # Thread.new do
        TincMailer.collision_resolve(reg.owner,node).deliver
    #  end
    end
  end

end
