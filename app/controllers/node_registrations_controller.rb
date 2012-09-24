class NodeRegistrationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :edit]
  
  filter_resource_access
  # GET /node_node_registrations
  # GET /node_node_registrations.json
  def index
    @node_node_registrations = NodeRegistration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @node_node_registrations }
    end
  end

  # GET /node_node_registrations/1
  # GET /node_node_registrations/1.json
  def show
    @registration = NodeRegistration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /node_node_registrations/new
  # GET /node_node_registrations/new.json
  def new
    @registration = NodeRegistration.new
    @registration.node = Node.find(params[:node]) if params[:node]
    @registration.owner = current_user
    @registration.osm_loc = "Suchbegriff"
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /node_node_registrations/1/edit
  def edit
    @registration = NodeRegistration.find(params[:id])
  end

  # POST /node_node_registrations
  # POST /node_node_registrations.json
  def create
    @registration = NodeRegistration.new(params[:registration])
    @registration.owner = current_user
    logger.debug "Role is #{current_user.role}"
    logger.debug "Registration is: #{@registration}"
    logger.debug "Node is: #{@registration.node}"
    
    respond_to do |format|
      if @registration.save
        format.html { redirect_to root_path, notice: 'Node erfolgreich registriert' }
        format.json { render json: @registration, status: :created, location: @registration }
      else
        format.html { render action: "new" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /node_node_registrations/1
  # PUT /node_node_registrations/1.json
  def update
    @registration = NodeRegistration.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        format.html { redirect_to @registration, notice: 'NodeRegistration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node_node_registrations/1
  # DELETE /node_node_registrations/1.json
  def destroy
    @registration = NodeRegistration.find(params[:id])
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to node_registrations_url }
      format.json { head :no_content }
    end
  end
end
