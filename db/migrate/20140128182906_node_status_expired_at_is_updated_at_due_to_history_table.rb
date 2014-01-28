class NodeStatusExpiredAtIsUpdatedAtDueToHistoryTable < ActiveRecord::Migration
  def up
  	rename_column :node_statuses, :expired_at, :updated_at
  end

  def down
  	rename_column :node_statuses, :updated_at, :expired_at
  end
end
