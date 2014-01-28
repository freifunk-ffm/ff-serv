class RemoveMacFromNodes < ActiveRecord::Migration
  def up
  	remove_column :nodes, :mac
  end

  def down
  end
end
