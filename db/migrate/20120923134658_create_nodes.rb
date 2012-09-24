class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :mac

      t.timestamps
    end
    add_index :nodes, :mac
  end
end
