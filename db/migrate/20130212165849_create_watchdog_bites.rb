class CreateWatchdogBites < ActiveRecord::Migration
  def change
    create_table :watchdog_bites do |t|
      t.integer :node_id
      t.datetime :node_stmp
      t.datetime :submission_stmp
      t.text :log_data

      t.timestamps
    end
    add_index :watchdog_bites, :node_id
    add_index :watchdog_bites, :node_stmp
    add_index :watchdog_bites, :submission_stmp
  end
end
