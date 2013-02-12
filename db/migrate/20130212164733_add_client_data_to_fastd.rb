class AddClientDataToFastd < ActiveRecord::Migration
  def change
    add_column :fastds, :client_ip, :string
    add_column :fastds, :vpn_server, :string
  end
end
