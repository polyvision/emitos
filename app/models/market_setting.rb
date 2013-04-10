class MarketSetting < ActiveRecord::Base
  attr_accessible :day, :closed_at, :opened_at

  def day_str
    if self.day == 0
      return "Sonntag"
    elsif self.day == 1
      return "Montag"
    elsif self.day == 2
      return "Dienstag"
    elsif self.day == 3
      return "Mittwoch"
    elsif self.day == 4
      return "Donnerstag"
    elsif self.day == 5
      return "Freitag"
    elsif self.day == 6
      return "Samstag"
    end
  end

  def self.is_market_open?
    begin
      weekday = Time.now.wday
      current_time = Time.zone.now

      market_setting = MarketSetting.where(:day => weekday).first
      opened_at = ActiveSupport::TimeZone.new("Berlin").parse("#{current_time.to_date.to_s} #{market_setting.opened_at.hour}:#{market_setting.opened_at.min}:00")
      closed_at = ActiveSupport::TimeZone.new("Berlin").parse("#{current_time.to_date.to_s} #{market_setting.closed_at.hour}:#{market_setting.closed_at.min}:00")

      puts "checking day: #{market_setting.day_str}"

      puts "current system time:#{current_time.to_s}"
      puts "market_setting.opened_at:#{opened_at}"
      puts "market_setting.closed_at:#{closed_at}"


      if current_time >= opened_at && current_time <= closed_at
        puts "market is open"
        return true
      end

      puts "market is closed at present"
      return false
    rescue Exception => ex
      puts ex.message
      puts "market is closed due to an exception in MarketSetting.is_market_open?"
      return false
    end
  end
end
