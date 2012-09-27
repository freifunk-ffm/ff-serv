class NodesController < ApplicationController
  def index
    @my_nodes = Node.registered
    @regable_nodes = Node.unregistered_home
  end
  
end
