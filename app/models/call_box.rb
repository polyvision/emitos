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

  def play_sound_on_psd
    begin
      TCPSocket.open(Setting.get_val("ESD_HOST"), Setting.get_val("PSD_PORT").to_i) { |s|
        s.send "PLAY #{self.sound_file.file.current_path}#", 0
      }
    rescue Exception => ex
      raise ex
    end
  end
end