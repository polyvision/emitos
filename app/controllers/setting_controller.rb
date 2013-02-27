class SettingController < ApplicationController
  before_filter :authenticate_user!

  def index
    @settings = Setting.all
  end

  def update
    settings = Setting.all
    settings.each do |setting|
      setting.value = params['setting'][setting.name]
      setting.save
    end
    flash[:notice] = I18n.t('flash.saved')
    redirect_to :action => 'index'
  end
end
