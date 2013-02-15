class CreateMarketSettings < ActiveRecord::Migration
  def change
    create_table :market_settings do |t|

      t.timestamps
      t.integer :day
      t.time  :opened_at
      t.time  :closed_at
    end

    MarketSetting.new(:day => 0).save # Sunday
    MarketSetting.new(:day => 1).save # Monday
    MarketSetting.new(:day => 2).save # Tuesday
    MarketSetting.new(:day => 3).save # Wednesday
    MarketSetting.new(:day => 4).save # Thursday
    MarketSetting.new(:day => 5).save # Friday
    MarketSetting.new(:day => 6).save # Saturday
  end
end
