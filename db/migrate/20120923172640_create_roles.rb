class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
    Role.new(:name => 'admin').save!
    Role.new(:name => 'user').save!
    add_index :roles, :name
  end
end
