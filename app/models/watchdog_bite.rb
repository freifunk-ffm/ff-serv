class WatchdogBite < ActiveRecord::Base
  belongs_to :node
  attr_accessible :log_data, :node_id, :node_stmp, :submission_stmp

  
end
