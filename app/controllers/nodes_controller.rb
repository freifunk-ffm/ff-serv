class NodesController < ApplicationController
  before_filter :authenticate_bot, :only => [:update_vpn_status,:vpn_down]
  
  def index
    @registered = Node.registered.includes([:status,:node_registration,:fastds])
    @unregistered = Node.unregistered.includes([:status,:node_registration])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json do
          resp = @registered.map do |node|
           reg = node.node_registration
           {:vpn_status => node.status.vpn_status.name,
             :status => {:created_at => I18n.l(node.status.created_at, :format => :short)},
             :node => {:id => node.id, :mac => node.mac, :mac_dec => node.mac.to_i(16), 
               :fw_version => ActionView::Base.full_sanitizer.sanitize(node.fw_version)},
             :node_registration => 
                { id: reg.id, 
                  latitude: reg.latitude, 
                  longitude: reg.longitude, 
                  name: ActionView::Base.full_sanitizer.sanitize(reg.name),
                  operator_name: ActionView::Base.full_sanitizer.sanitize(reg.operator_name),
                  operator_email: r_23(ActionView::Base.full_sanitizer.sanitize(reg.operator_email)),
                  loc_str: ActionView::Base.full_sanitizer.sanitize(reg.loc_str),
                  osm_loc: ActionView::Base.full_sanitizer.sanitize(reg.osm_loc),
                  created_at: reg.created_at,
                  updated_at: reg.updated_at
                }
            }
         end
         render json: resp
       end
    end
  end

  #VPN-Status eines Nodes aktualisieren
  def update_vpn_status
    # Request parameters
    mac = params[:mac]
    vpn_status_name = params[:vpn_status]
    vpn_sw = params[:vpn_sw]
    ip = params[:ip]
    vpn_status = VpnStatus.find_by_name vpn_status_name
    node = Node.find_or_create_by_mac mac
    node.update_vpn_status vpn_status,ip,vpn_sw
    render status: :created, :text => ""
  end

  #VPN-Status aller Nodes nach down aendern - VPN wird abgeschaltet (das VPN wird mit dem Namen "vpn" benannt)
  def vpn_down
    vpn_sw = params[:vpn_sw]
    vpn_status = VpnStatus.DOWN
    Node.all.each do |node|
      node.update_vpn_status vpn_status,"0.0.0.0",vpn_sw
    end
    render status: :created, :text => ""
  end
end
