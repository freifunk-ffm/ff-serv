class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :copy_user
  
  private
  def copy_user
    Authorization.current_user = current_user || User.new
    Authorization.current_user.current_ip = request.remote_ip
  end
end
