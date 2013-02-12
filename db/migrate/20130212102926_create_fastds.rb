class CreateFastds < ActiveRecord::Migration
  def change
    create_table :fastds do |t|
      t.integer :node_id
      t.string :fw_version
      t.string :key, :index => true

      t.timestamps
    end
  end
end
