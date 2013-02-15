class MarketSetting < ActiveRecord::Base
  attr_accessible :day, :closed_at,:opened_at

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
end
