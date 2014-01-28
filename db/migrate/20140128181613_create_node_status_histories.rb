class CreateNodeStatusHistories < ActiveRecord::Migration
  def up
    create_table :node_status_histories do |t|
      t.column :node_id, :BigInt
      t.integer :vpn_status_id
      t.string :fw_version
      t.string :initial_conf_version
      t.string :vpn_sw_name
      t.string :ip
      t.integer :viewpoint_id
      t.datetime :expired_at
      t.timestamps
    end
    add_index :node_status_histories, :node_id
    add_index :node_status_histories, :vpn_status_id
    add_index :node_status_histories, :viewpoint_id
    ActiveRecord::Base.connection.execute("INSERT into node_status_histories(node_id,vpn_status_id,fw_version,initial_conf_version,vpn_sw_name,ip,viewpoint_id,created_at)
      SELECT node_id,vpn_status_id,fw_version,initial_conf_version,vpn_sw_name,ip,viewpoint_id,created_at from node_statuses")
    #ActiveRecord::Base.connection.execute("DELETE from node_statuses where expired_at is not null");
  end
end
