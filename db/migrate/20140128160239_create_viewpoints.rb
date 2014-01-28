class CreateViewpoints < ActiveRecord::Migration
  def change
    create_table :viewpoints do |t|
      t.string :name
      t.timestamps
    end
  	add_column :node_statuses, :viewpoint_id, :int
  	add_index :node_statuses, :viewpoint_id
  	remove_column :node_statuses, :viewpoint
  end

end
