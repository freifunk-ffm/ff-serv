class RemoveClientIpFromFastd < ActiveRecord::Migration
  def up
    remove_column :fastds, :client_ip
  end

  def down
    add_column :fastds, :client_ip, :string
  end
end
