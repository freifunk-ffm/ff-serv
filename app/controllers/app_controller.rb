class AppController < ApplicationController
  before_filter :auth_as_mailman, :only => [:email_addresses]
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
  
  # http-auth using mailman_auth.yml's crendentials
  # Used for protecting the address list
  private
  def auth_as_mailman
    @@mailman_config ||= YAML::load_file("#{Rails.root}/config/mailman_auth.yml")
    authenticate_or_request_with_http_basic do |username, password|
      username == @@mailman_config['user'] && password = @@mailman_config['password']
    end
  end
  
end
