class Viewpoint < ActiveRecord::Base
  attr_accessible :name
  scope :ord, order('name asc')

  def self.cnt
  	Viewpoint.count
  end

end
