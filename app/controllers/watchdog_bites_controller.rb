class WatchdogBitesController < ApplicationController
  # GET /watchdog_bites
  # GET /watchdog_bites.json
  def index
    @watchdog_bites = WatchdogBite.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @watchdog_bites }
    end
  end

  # POST /watchdog_bites
  # POST /watchdog_bites.json
  def create
    @watchdog_bite = WatchdogBite.new(params[:watchdog_bite])
    mac = params[:node_id]
    node_stmp = params[:tstmp]
    log_data = params[:dmesg]
    submission_stmp = params[:submission_stmp]

    WatchdogBite.transaction do
      node = Node.find_or_create_by_mac mac
      w_b = WatchdogBite.new({
        :log_data => log_data, 
        :node_id => node.id, 
        :node_stmp => Time.at(node_stmp || 0) , 
        :submission_stmp => Time.at(submission_stmp || 0)
      })
      w_b.save!
      render format.json { render json: w_b, status: :created, location: w_b }
    end
  end

  def show
    @watchdog_bite = WatchdogBite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @watchdog_bite }
    end
  end
  

end
