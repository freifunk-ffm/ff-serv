class AddOsmLocToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :osm_loc, :string
  end
end
