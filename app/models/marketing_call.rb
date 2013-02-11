class MarketingCall < ActiveRecord::Base
  attr_accessible :sound_file_id, :name, :play_at, :use_matrix,:day_matrix, :minutes_pro_call
  belongs_to :sound_file
end
