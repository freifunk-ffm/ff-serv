class AddFwVersionToNode < ActiveRecord::Migration
  def up
    add_column :nodes, :fw_version, :string
    ActiveRecord::Base.connection.execute("UPDATE nodes n SET fw_version = (SELECT fw_version from fastds f where f.node_id = n.id AND fw_version IS NOT NULL order by created_at DESC LIMIT 1)")
  end
end
