class SoundFile < ActiveRecord::Base
  attr_accessible :file, :sound_group_id

  mount_uploader :file, SoundFileUploader

  belongs_to :sound_group

  def filename
    begin
      return File.basename(self.file.current_path)
    rescue Exception => ex
    end
  end

  def to_s
    begin
      return "#{self.sound_group.name} - #{self.filename}"
    rescue Exception => ex
    end
  end
end
