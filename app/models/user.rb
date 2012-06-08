class User < ActiveRecord::Base
  attr_accessible :role_id, :name
  attr_accessor :current_ip
  before_create :set_role
  
  require 'digest/md5'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable 

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  belongs_to :role
  
  def role_symbols
    (role.present?) ? [role.name.to_sym] : []
  end
  
  def to_s
    "#{email}"
  end
  
  def image_url
    digest = Digest::MD5.hexdigest("#{email}".downcase)
    return "http://www.gravatar.com/avatar/#{digest}"
  end
  
  def set_role
    role_id = Role.user.id
  end
end
