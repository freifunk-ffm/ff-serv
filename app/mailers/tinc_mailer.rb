# encoding: UTF-8
class TincMailer < ActionMailer::Base
  default from: 'info@ffm.freifunk.net'

  def new_approved_email(user,node)
      @user = user
      @node  = node
      headers 'X-FFM' => 'new_approved_email'
      mail(:to => user.email, :subject => "Node #{node.mac} ist nun Teil des Freifunk-Netzes")
  end

  def collision_info(user,node)
    @user = user
    @node = node
    headers 'X-FFM' => 'collision_info'
    mail(:to => user.email, :subject => "Node #{node.mac}: Abweichender Key eingereicht")
  end

  def collision_resolve(user,node)
    @user = user
    @node = node
    headers 'X-FFM' => 'collision_resolve'
    mail(:to => user.email, :subject => "Node #{node.mac}: VPN-Schlüssel muss bestätigt werden")
  end
end
