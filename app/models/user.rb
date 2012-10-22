class User < ActiveRecord::Base
  before_create :set_default_role
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  attr_accessor :current_ip
  belongs_to :role
  has_many :node_registrations, :foreign_key => "owner_id"
  has_many :nodes, :through => :node_registrations
  
  def role_symbols
    (role.present?) ? [role.name.to_sym] : [:guest] 
  end
  
  def to_s
    "#{email}"
  end
  
  def self.APPLICATION
    @@auto_approver ||= User.create(:email => "ffserv")
  end
  
  private 
  def set_default_role
    self.role = Role.USER
  end
end
class Authorization::AnonymousUser
  def current_sign_in_ip
    nil
  end
end