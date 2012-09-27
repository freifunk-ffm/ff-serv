authorization do
  
  # Administrator
  role :admin do
    has_permission_on :nodes, :to => [:index,:create, :read, :update, :delete, :register]
    has_permission_on :node_registrations, :to => :manage
    has_permission_on :users, :to => :manage
  end

  
  #User: Registrierter User
  role :user do
    has_permission_on :nodes do
      to :register
      if_attribute :status => {:ip => is {user.current_ip}}
    end
    
    has_permission_on :node_registrations, :to => [:new,:index,:read]
    has_permission_on :node_registrations, :to => [:new,:create] do
      #if_attribute :loc_str => is {'abc'}
      if_permitted_to :register, :node
    end
    
    has_permission_on :node_registrations do
      to :update
      if_attribute :owner => is {user}
    end
  end
  
  #Guest: Nicht angemeldeter Server
  role :guest do
    has_permission_on :nodes, :to => [:read]
    has_permission_on :node_registrations, :to => [:index,:read]
    # Hack: Don't panic for missing rules, since a rule never to be fullfilled is defined
    has_permission_on :nodes do
        to :register
        if_attribute :mac => is {'nosuchmac'}
      end
    end
end