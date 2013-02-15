class MarketingCallController < ApplicationController

  def index
    @marketing_calls = MarketingCall.all
  end

  def new
    @marketing_call = MarketingCall.new
  end

  def create
    @marketing_call = MarketingCall.new(params[:marketing_call])
    @marketing_call.update_matrix(params)
    @marketing_call.save
    redirect_to :action => 'index'
  end

  def edit
    @marketing_call = MarketingCall.find(params[:id])
  end

  def update

    @marketing_call = MarketingCall.find(params[:id])
    @marketing_call.update_attributes(params[:marketing_call])
    @marketing_call.update_matrix(params)
    redirect_to :action => 'index'
  end
end