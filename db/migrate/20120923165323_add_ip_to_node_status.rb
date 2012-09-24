class AddIpToNodeStatus < ActiveRecord::Migration
  def change
    add_column :node_statuses, :ip, :string
    add_index :node_statuses, :ip
  end
end
