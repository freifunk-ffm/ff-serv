class RenameNodeRegistrations < ActiveRecord::Migration
  def change
    rename_table :registrations, :node_registrations
    rename_column :nodes, :registration_id, :node_registration_id
  end 
end
