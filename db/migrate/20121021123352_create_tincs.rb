class CreateTincs < ActiveRecord::Migration
  def change
    create_table :tincs do |t|
      t.integer :node_id
      t.datetime :approved_at
      t.integer :approved_by
      t.datetime :revoked_at
      t.integer :revoked_by
      t.string :ip_address, :limit => 63
      t.string :certfp, :limit => 255
      t.text :cert_data

      t.timestamps
    end
    add_index :tincs, :node_id
    add_index :tincs, :approved_at
    add_index :tincs, :revoked_at
    add_index :tincs, :certfp
  end
end
