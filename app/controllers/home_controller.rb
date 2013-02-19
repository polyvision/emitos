class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @active_call_boxes_stats = CallBoxStatistic.active_boxes
  end

  def active_call_boxes
  	@active_call_boxes_stats = CallBoxStatistic.active_boxes
  	render :layout => false
  end
end
