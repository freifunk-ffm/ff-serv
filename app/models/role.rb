class Role < ActiveRecord::Base
  
  attr_accessible :name
  has_many :users

  def self.ADMIN
    find_or_create_by_name("admin")
  end
  def self.USER
    find_or_create_by_name("user")
  end
  def self.NODE
    find_or_create_by_name("node")
  end

  def to_s
    "#{name}"
  end
end
