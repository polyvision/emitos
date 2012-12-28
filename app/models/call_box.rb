require 'socket'

class CallBox < ActiveRecord::Base
  attr_accessible :name,:mac, :sound_file_id

  belongs_to :sound_file

  def play_sound_on_psd
  	begin
  		TCPSocket.open(Setting.get_val("ESD_HOST"),Setting.get_val("PSD_PORT").to_i) {|s|
  			s.send "PLAY #{self.sound_file.file.current_path}#", 0
		}
	rescue Exception => ex
		raise ex
	end
  end
end