class MoveNodeIdToRegistration < ActiveRecord::Migration
  def up
  	add_column :node_registrations, :node_id, :BigInt
  	ActiveRecord::Base.connection.execute("UPDATE node_registrations nr set nr.node_id = (select n.id from nodes n where n.node_registration_id = nr.id)")
  	
  	add_index :node_registrations, :node_id
  	remove_column :nodes, :node_registration_id
  end

  def down
  	remove_column :node_registrations, :node_id
  end
end
