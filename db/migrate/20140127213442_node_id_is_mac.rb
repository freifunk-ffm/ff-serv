class NodeIdIsMac < ActiveRecord::Migration
  def update_node_id(m)
  	m.update_attribute(:node_id, m.node.mac.to_i(16)) if m.node.present?
  end

  def up
  	Fastd.all(:include => :node).each { |f| update_node_id(f) }
  	NodeStatus.all(:include => :node).each { |f| update_node_id(f) }
  	Tinc.all(:include => :node).each { |f| update_node_id(f) }
  	WatchdogBite.all(:include => :node).each { |f| update_node_id(f) }
  	
  	Node.all.each do |n| 
  		begin 
  			ActiveRecord::Base.connection.execute "UPDATE nodes set id=#{n.mac.to_i(16)} where id = #{n.id}" 
  		rescue Exception => e
  			puts "#{e}"
  		end
   	end
   end

  def down
  end
end
