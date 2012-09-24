class AddVpnStatusData < ActiveRecord::Migration
  def up
    VpnStatus.new(:name => 'up').save!
    VpnStatus.new(:name => 'down').save!
  end

  def down
    VpnStatus.new(:name => 'up').destroy!
    VpnStatus.new(:name => 'down').destroy!
  end
end
