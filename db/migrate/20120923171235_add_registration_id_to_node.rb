class AddRegistrationIdToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :registration_id, :integer
    add_index :nodes, :registration_id
  
  end
end
