class CreateNodeStatuses < ActiveRecord::Migration
  def change
    create_table :node_statuses do |t|
      t.integer :node_id
      t.integer :vpn_status_id
      t.string :fw_version
      t.string :initial_conf_version
      t.string :vpn_sw_name

      t.timestamps
    end
    add_index :node_statuses, :node_id
    add_index :node_statuses, :vpn_status_id
  end
end
