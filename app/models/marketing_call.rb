class MarketingCall < ActiveRecord::Base
  attr_accessible :sound_file_id, :name, :play_at, :use_matrix,:day_matrix, :minutes_pro_call
  belongs_to :sound_file

  def update_matrix(params)
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
    json_data = JSON::parse(self.day_matrix)
    return json_data[index]
  end

  def matrix_str
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
end
