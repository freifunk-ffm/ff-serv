class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :copy_user
  
  private
  def copy_user
    Authorization.current_user = current_user || User.new
  end
  #Authenticate for Node-based-Request:
  #User: Mac of wlan module
  #Password: Mac of first wired nic (eg eth0)
  def authenticate_mac
    authenticate_or_request_with_http_basic do |username, password|
        logger.info "Node login: #{username} #{password}"
        # Node-ids consist of 12 hexadecimal chars (mac-address of node)
        # In order to prevent shell-code injection, all submitted data is checked by a regular expression
        session[:wlan_mac] = username
        session[:bat0_mac] = password
        username.match(/^[0-9a-f]{12}$/i) && password.match(/^[0-9a-f]{12}$/i)
      end
    end

end
