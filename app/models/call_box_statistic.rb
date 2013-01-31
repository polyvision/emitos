class CallBoxStatistic < ActiveRecord::Base
	STATE_ACTIVE = 1
	STATE_DEACTIVATED_BY_CUSTOMER = 2
	STATE_DEACTIVATED_BY_DAEMON = 3
	
  	# attr_accessible :title, :body
	belongs_to :call_box

  def self.active_boxes
  	CallBoxStatistic.where("state=?",CallBoxStatistic::STATE_ACTIVE)
  end
end
