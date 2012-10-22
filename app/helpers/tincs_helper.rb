# encoding: UTF-8

module TincsHelper

  def approve_link(tinc)
    if tinc.can_approve? && permitted_to?(:approve, tinc)
      link_to 'Akzeptieren', approve_tinc_path(tinc), :method => :post if tinc.can_approve?
    end
  end

  def revoke_link(tinc)
    if tinc.can_approve? && permitted_to?(:revoke, tinc)
      link_to 'Zurück ziehen', revoke_tinc_path(tinc), :method => :post if tinc.can_revoke?
    end
  
  end
end
