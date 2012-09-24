class AddNoticeToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :notice, :text
  end
end
