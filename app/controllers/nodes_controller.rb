class NodesController < ApplicationController
  def index
    @registered = Node.registered
    @unregistered = Node.unregistered
  end
  
end
