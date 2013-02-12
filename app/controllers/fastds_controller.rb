class FastdsController < ApplicationController
  before_filter :authenticate_bot, :only => [:create]

  # GET /fastds
  # GET /fastds.json
  def index
    @fastds = Fastd.includes(:node).order('updated_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fastds }
    end
  end

  # POST /fastds
  # POST /fastds.json
  def create
    Fastd.transaction do
      @fastd = Fastd.find_or_create_by_key params[:key]
      rip = request.remote_ip
      vpn_s = @fastd.vpn_server
      if vpn_s.blank? || !vpn_s.include?(rip)
        @fastd.vpn_server = "#{rip} #{vpn_s}"
      end

      @fastd.node = Node.find_or_create_by_mac params[:mac]
      @fastd.fw_version = params[:fw_version]
      @fastd.updated_at = DateTime.now
      @fastd.save!
      render text: "", status: :created
    end
  end
end
