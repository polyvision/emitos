class SoundFile < ActiveRecord::Base
  attr_accessible :file, :sound_group_id

  mount_uploader :file,SoundFileUploader

  belongs_to :sound_group

  def filename
  	return File.basename(self.file.current_path)
  end

  def to_s
  	return "#{self.sound_group.name} - #{self.filename}"
  end
end
