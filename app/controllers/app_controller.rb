class AppController < ApplicationController
  def index
    #Welcome page ...
    
    @regable_nodes = Node.unregistered_home
    @my_nodes = []
    @my_nodes = current_user.nodes if current_user
  end
end
