class ExpiredAtNullable < ActiveRecord::Migration
  def up
    change_column :node_statuses, :expired_at, :datetime, :null => true
    
  end

  def down
    change_column :node_statuses, :expired_at, :datetime, :null => false
  end
end
