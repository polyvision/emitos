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
    t = Hash.new
    t['Standard'] = CallBox::TYPE_DEFAULT
    t['SMS / VoiceMail'] = CallBox::TYPE_NOTIFICATION
    return t
  end

  def notify(num_call = 1)

    # first call
    if num_call == 1 && self.call_one_type == CallBox::TYPE_NOTIFICATION # SMS
      self.notify_per_sms(num_call,self.call_one_notification_number)
    else
      self.play_sound_on_psd(num_call)
    end

    # 2nd call
    if num_call == 2 && self.call_two_type == CallBox::TYPE_NOTIFICATION # SMS
      self.notify_per_sms(num_call,self.call_two_notification_number)
    else
      self.play_sound_on_psd(num_call)
    end

    # 3rd call
    if num_call == 3 && self.call_three_type == CallBox::TYPE_NOTIFICATION # SMS
      self.notify_per_sms(num_call,self.call_three_notification_number)
    else
      self.play_sound_on_psd(num_call)
    end
  end

  def notify_per_sms(num_call,send_to)
    msg = "#{num_call}. Aufruf #{self.name}"
    mobilant = PvMobilant::Api.new("5qYMWmf975212a0a9NHWsXa")
    mobilant.sms_route = Setting.get_val("MOBILANT_ROUTE")
    response = mobilant.send_sms("EMITOS",send_to,msg)

    # logging the sms notification
    cbn = CallBoxNotification.new
    cbn.msg = msg
    cbn.send_to = send_to
    cbn.response_code = response['response_code']
    cbn.response_msg_id = response['response_msg_id']
    cbn.response_cost = response['response_cost']
    cbn.sms_count = response['response_sms_count']
    cbn.sms_route = mobilant.sms_route
    cbn.save
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
      ##
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
          cbs.call_box.notify(cbs.num_call) # playing another sound
        end
      end # last_call_time
    end # end of call_box_statistic.each
  end
end