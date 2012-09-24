class CreateVpnStatuses < ActiveRecord::Migration
  def change
    create_table :vpn_statuses do |t|
      t.string :name

      t.timestamps
    
    end
  end
end
