class SettingMarketSettings < ActiveRecord::Migration
  def up
    Setting.new(:name => 'MARKET_SETTING_MARKET_CALLS_ACTIVE',:value => 1).save
    Setting.new(:name => 'MARKET_SETTING_MARKETING_CALLS_ACTIVE',:value => 1).save
  end

  def down
  end
end
