class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :copy_user
  
  private
  def copy_user
    Authorization.current_user = current_user || User.new
  end
  
  def authenticate_http
    authenticate_or_request_with_http_basic do |username, password|
      user = User.find_by_email(username)
      user.present? && user.valid_password?(password)
    end
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

    def authenticate_localhost
       request.local?
    end

    # http-auth using mailman_auth.yml's crendentials
    # Used for protecting the address list
    private
    def authenticate_bot
      @@mailman_config ||= YAML::load_file("#{Rails.root}/config/bot_auth.yml")
      authenticate_or_request_with_http_basic do |username, password|
        username == @@mailman_config[user].present? && password = @@mailman_config[user]['password']
      end
    end
end
