class ChangeIdToBigintNode < ActiveRecord::Migration
  def up
      change_table :fastds do |t|
        t.change :node_id, :BigInt
      end
      change_table :nodes do |t|
        t.change :id, :BigInt
      end
     change_table :node_statuses do |t|
        t.change :node_id, :BigInt
      end
     change_table :tincs do |t|
        t.change :node_id, :BigInt
      end
     change_table :watchdog_bites do |t|
        t.change :node_id, :BigInt
      end
  end
  
  def down
      change_table :fastds do |t|
        t.change :node_id, :int
      end
      change_table :nodes do |t|
        t.change :id, :int
      end
     change_table :node_statuses do |t|
        t.change :node_id, :int
      end
     change_table :tincs do |t|
        t.change :node_id, :int
      end
     change_table :watchdog_bites do |t|
        t.change :node_id, :int
      end
  end


end
