class AppController < ApplicationController
  before_filter :authenticate_bot, :only => [:email_addresses]
  #Welcome page ...
  def index
    @regable_nodes = Node.unregistered_home(request.remote_ip)
    @my_nodes = []
    @my_nodes = current_user.nodes if current_user
  end

  # Map of the network
  def map; end
  
  # Operator + User-E-Mail addresses for mailman export
  def email_addresses
    addrs = []
    addrs += NodeRegistration.select(:operator_email).map{|n| n.operator_email}.compact
    addrs += User.select(:email).map{|n| n.email}.compact
    addrs.uniq!
    render :text => addrs.uniq.join(', ')
  end
  

  
end
