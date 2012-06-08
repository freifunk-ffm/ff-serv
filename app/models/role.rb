class Role < ActiveRecord::Base
  attr_accessible :name
  
  has_many :users
  def to_s
    "#{name}"
  end
  
  def self.localhost
    @@role_localhost ||= Role.find_by_name('localhost')
  end
  
  def self.node
    @@role_node ||= Role.find_by_name('node')
  end
  
  def self.user
    @@role_user ||= Role.find_by_name('user')
  end

end
