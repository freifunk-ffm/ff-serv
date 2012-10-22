class NodeRegistrationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:edit]

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
    p = params[:node_registration]
    
    @registration = NodeRegistration.new(latitude: p[:latitude],longitude:  p[:longitude],
      operator_name: p[:operator_name], operator_email: p[:operator_email],
      name: p[:name], node_at: p[:node_at],notice: p[:notice],
      loc_str: p[:loc_str], osm_loc: p[:osm_loc])
    
    if permitted_to?(:set_owner, @registration)
      @registration.owner_id = p[:owner_id]
    else
      @registration.owner = current_user
    end
    @registration.creator = current_user
    @registration.updater = current_user

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
    p = params[:node_registration]
    @registration = NodeRegistration.find(params[:id])
    if permitted_to?(:set_owner, @registration)
      @registration.owner_id = p[:owner_id]
    else
      @registration.owner = current_user
    end
    @registration.updater = current_user

    respond_to do |format|
      if @registration.update_attributes(latitude: p[:latitude],longitude: p[:longitude],
        operator_name: p[:operator_name], operator_email: p[:operator_email],
        name: p[:name], node_at: p[:node_at],notice: p[:notice],
        loc_str: p[:loc_str], osm_loc: p[:osm_loc])
        
        format.html { redirect_to nodes_path, notice: 'Registrierung erfolgreich gespeichert.' }
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
