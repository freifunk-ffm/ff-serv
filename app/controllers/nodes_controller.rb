class NodesController < ApplicationController
  def index
    @registered = Node.registered
    @reg_able = Node.unregistered_home
  end
end
