class NodeStatusesController < ApplicationController
  def index
    node_id = params[:node]
    if(node_id)
      @node = Node.find(node_id)
      @node_statuses = NodeStatus.where("node_id = ?",node_id).order("created_at DESC")
      render :action => 'node_status', :object => @node_statuses
    else
      @node_statuses = NodeStatus.where("expired_at IS NULL").order("created_at DESC").includes(:node)
    end
  end
end
