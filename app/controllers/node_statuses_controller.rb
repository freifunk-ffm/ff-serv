class NodeStatusesController < ApplicationController
  def index
    node_id = params[:node]
    if(node_id)
      @node = Node.find(node_id)
      @node_statuses = NodeStatusHistory.where("node_id = ?",node_id).order("created_at DESC")
    else
      @node_statuses = NodeStatusHistory.where("expired_at IS NULL").order("created_at DESC").includes(:node)
    end
    render :action => 'node_status', :object => @node_statuses
  end
end
