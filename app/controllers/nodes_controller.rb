class NodesController < ApplicationController
  def index
    @registered = Node.registered.includes([:status,:node_registration])
    @unregistered = Node.unregistered.includes([:status,:node_registration])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json do
          resp = @registered.map do |node|
           reg = node.node_registration
           {:vpn_status => {:name => node.status.vpn_status.name},
             :status => {:created_at => I18n.l(node.status.created_at, :format => :short)},
             :node => {:id => node.id, :mac => node.mac},
             :node_registration => {:id => reg.id, :latitude => reg.latitude, :longitude => reg.longitude, :name => ActionView::Base.full_sanitizer.sanitize(reg.name)}}
         end
         render json: resp
       end
    end
  end
  
end
