class AddViewpointToNodeStatus < ActiveRecord::Migration
  def change
    add_column :node_statuses, :viewpoint, :string
    add_index :node_statuses, :viewpoint
  end
end
