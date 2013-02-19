class MarketSettingController < ApplicationController
  before_filter :authenticate_user!

  def index
    @market_setting = MarketSetting.where(:day => 0).first
  end

  def market_setting_week_day
    @market_setting = MarketSetting.find(params[:id])
    render :layout => false
  end

  def update_market_setting_week_day
    @market_setting = MarketSetting.find(params[:id])
    @market_setting.update_attributes(params[:market_setting])
    respond_to do |format|
      format.js do
        render :text => 'alert("Gespeichert!");'
      end
    end
  end

  def update

    v = Setting.where(:name => "MARKET_SETTING_MARKET_CALLS_ACTIVE").first
    if params[:market_call_active]
      v.value = params[:market_call_active].to_i
    else
      v.value = 0
    end
    v.save

    v = Setting.where(:name => "MARKET_SETTING_MARKETING_CALLS_ACTIVE").first
    if params[:marketing_calls_active]
      v.value = params[:marketing_calls_active].to_i
    else
      v.value = 0
    end
    v.save

    respond_to do |format|
      format.js do
        render :text => 'alert("Gespeichert!");'
      end
    end
  end
end
