require 'socket'

class CallBox < ActiveRecord::Base
  TYPE_DEFAULT = 0
  TYPE_NOTIFICATION = 1

  attr_accessible :name, :mac, :sound_file_id, :jingle_file_id, :max_calls
  attr_accessible :call_one_type, :call_one_notification_number
  attr_accessible :call_two_type, :call_two_notification_number
  attr_accessible :call_three_type, :call_three_notification_number

  belongs_to :sound_file
  belongs_to :jingle_file, :class_name => 'SoundFile'

  def self.form_type_collection
    t = Array.new
    t[CallBox::TYPE_DEFAULT] = 'Standard'
    t[CallBox::TYPE_NOTIFICATION] = 'SMS / VoiceMail'
    return t
  end

  def play_sound_on_psd(num_call = 1)
    begin

      if self.jingle_file # playing the jingle
        for t in 0..num_call-1 do
          TCPSocket.open(Setting.get_val("ESD_HOST"), Setting.get_val("PSD_PORT").to_i) { |s|
            s.send "PLAY #{self.jingle_file.file.current_path}#", 0
          }
        end
      end

      TCPSocket.open(Setting.get_val("ESD_HOST"), Setting.get_val("PSD_PORT").to_i) { |s|
        s.send "PLAY #{self.sound_file.file.current_path}#", 0
      }
    rescue Exception => ex
      raise ex
    end
  end

  def max_time_between_call
    return 30 # default 30 sekunden zwischen jedem aufruf
  end

=begin
 calculating the cycle for the stations
=end
  def self.cycle
    call_box_statistic = CallBoxStatistic.where("state=?", CallBoxStatistic::STATE_ACTIVE)
    call_box_statistic.each do |cbs|
      last_call_time = cbs.updated_at.to_i + cbs.call_box.max_time_between_call
      if last_call_time < Time.now.to_i
        if cbs.num_call + 1 > cbs.call_box.max_calls
          cbs.state = CallBoxStatistic::STATE_DEACTIVATED_BY_DAEMON
          cbs.save
        else
          cbs.num_call +=1
          cbs.save
          cbs.call_box.play_sound_on_psd(cbs.num_call) # playing another sound
        end
      end # last_call_time
    end # end of call_box_statistic.each
  end
end