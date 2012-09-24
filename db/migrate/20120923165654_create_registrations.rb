class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :name
      t.string :operator_name
      t.string :operator_email
      t.string :loc_str
      t.float :latitude
      t.float :longitude
      t.integer :owner_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
    add_index :registrations, :name
    add_index :registrations, :owner_id
  end
end
