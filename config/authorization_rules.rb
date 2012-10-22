authorization do
  
  # Administrator
  role :admin do
    has_permission_on :nodes, :to => [:index,:create, :read, :update, :delete, :register]
    has_permission_on :node_registrations, :to => [:index,:create, :read, :update, :delete,:set_owner]
    has_permission_on :users, :to => :manage
    has_permission_on :tincs, :to => [:approve,:revoke]
  
  end

  
  #User: Registrierter User
  role :user do
    has_permission_on :nodes do
      to :register
      if_attribute :status => {:ip => is {user.current_sign_in_ip}}
    end
    has_permission_on :nodes, :to => [:update,:create]
    
    has_permission_on :node_registrations, :to => [:new,:index,:read]
    has_permission_on :node_registrations, :to => [:new,:create] do
      if_permitted_to :register, :node
    end
    
    has_permission_on :node_registrations do
      to [:update, :delete,:edit]
      if_attribute :owner => is {user}
    end

    has_permission_on :tincs do
      to [:approve,:revoke]
      if_attribute :node => {:node_registration => {:owner => is {user}}}
    end
    

  end
  
  #Guest: Nicht angemeldeter Server
  role :guest do
    has_permission_on :nodes, :to => [:read,:index,:create,:update]
    has_permission_on :node_registrations, :to => [:index,:read]
    # Hack: Don't panic for missing rules, since a rule never to be fullfilled is defined
    has_permission_on :nodes do
        to :register
        if_attribute :mac => is {'nosuchmac'}
      end
    end
end