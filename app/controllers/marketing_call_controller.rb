class MarketingCallController < ApplicationController

  def index
    @marketing_calls = MarketingCall.all
  end

  def new
    @marketing_call = MarketingCall.new
  end

  def create
    @marketing_call = MarketingCall.new(params[:marketing_call])
    @marketing_call.save
    redirect_to :action => 'index'
  end
end
