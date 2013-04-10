class MarketingCall < ActiveRecord::Base
  attr_accessible :sound_file_id, :name, :play_at, :use_matrix, :day_matrix, :minutes_pro_call
  belongs_to :sound_file

  def update_matrix(params)
    if !params[:matrix]
      self.day_matrix = Array.new.to_json
      self.save
      return
    end


    json_data = Array.new
    for i in 0..6 do
      if params[:matrix][i.to_s] == "on"
        json_data[i] = true
      else
        json_data[i] = false
      end
    end

    self.day_matrix = json_data.to_json
    self.save
  end

  def check_matrix(index)
    if self.day_matrix
      json_data = JSON::parse(self.day_matrix)
      return json_data[index]
    else
      return false
    end
  end

  # helper method to check if the call should be played today, the time doesn matter.. just the day matrix
  def play_today?
    if self.use_matrix == false #der tag ist egal
      return true
    end

    if !self.day_matrix #tag ist nicht egal, ist gibt aber keinen aktiven tag...
      return false
    end

    cweekday = Time.now.to_date.cwday

    if self.check_matrix(cweekday)
      return true
    end
    return false
  end

  def matrix_str
    if !self.day_matrix
      return ""
    end
    json_data = JSON::parse(self.day_matrix)

    days = ""

    if json_data[0]
      days << "So,"
    end

    if json_data[1]
      days << "Mo,"
    end

    if json_data[2]
      days << "Di,"
    end

    if json_data[3]
      days << "Mi,"
    end

    if json_data[4]
      days << "Do,"
    end

    if json_data[5]
      days << "Fr,"
    end

    if json_data[6]
      days << "Sa,"
    end
    return days
  end

  def play_sound_on_psd
    begin
      TCPSocket.open(Setting.get_val("ESD_HOST"), Setting.get_val("PSD_PORT").to_i) { |s|
        s.send "PLAY #{self.sound_file.file.current_path}#", 0
      }
    rescue Exception => ex
      puts "#{self.id} MarketingCall.play_sound_on_psd error: #{ex.message}"
    end
  end

  # returns the play at converted to the current day
  def current_play_at
    return Time.zone.parse("#{Time.now.to_date.year}-#{Time.now.to_date.month}-#{Time.now.to_date.day} #{self.play_at.hour}:#{self.play_at.min}")
  end

  def already_played_today?
    lpa = self.last_played_at
    if !lpa
      return false
    end

    ct = Time.now
    if lpa.year == ct.year && lpa.month == ct.month && lpa.day == ct.day
      return true
    end

    return false
  end

  def self.cycle
    if MarketSetting.is_market_open? == false
      puts "MarketingCall.cycle: aborted cause market is closed"
      return
    end

    MarketingCall.all.each do |mc|
      if (mc.play_today?)
        if mc.minutes_pro_call != 0
          MarketingCall::cycle_non_time_based(mc)
        else # it's clock time based
          MarketingCall::cycle_time_based(mc)
        end # minutes pro call != 0
      else
        puts "MarketingCall.cycle: play_today? NO ##{mc.id} #{mc.name}"
      end # check play_today?
    end # marketing call each
  end

  def self.cycle_time_based(mc)
    puts "MarketingCall:cycle_time_based  ##{mc.id} #{mc.name}"
    if mc.already_played_today? == false
      if mc.current_play_at.to_i <= Time.now.to_i
        mc.play_sound_on_psd
        mc.last_played_at= Time.now
        mc.save
        puts "MarketingCall:cycle_time_based: playing call ##{mc.id} #{mc.name}"
      end
    else
      puts "MarketingCall:cycle_time_based: already_played_today? YES  ##{mc.id} #{mc.name}"
    end # mc.already_played_today? == false
  end

  def self.cycle_non_time_based(mc)
    puts "MarketingCall:cycle_non_time_based  ##{mc.id} #{mc.name}"
    last_played_at_cal = (mc.minutes_pro_call * 60) # default value
    if mc.last_played_at && mc.last_played_at.to_s.length > 1 # in the first run, it's null
      last_played_at_cal = Time.now.to_i - mc.last_played_at.to_i
    end

    if last_played_at_cal >= (mc.minutes_pro_call * 60)

      mc.last_played_at = Time.now
      mc.save
      mc.play_sound_on_psd
      puts "MarketingCall:cycle_non_time_based: playing call ##{mc.id} #{mc.name}"
    end
  end
end