=begin
load "#{Rails.root}/lib/import.rb"
Import.process(SoundFileGroup.find(1),"#{Rails.root}/3rd/Rufdurchsagen/*")
=end
class Import
  def self.process(sound_file_group,dir)
    entries = Dir[dir]
    entries.each do |entry|

      sound_file_entry = SoundFile.new
      sound_file_entry.sound_group_id = sound_file_group.id
      sound_file_entry.file = File.new(entry)
      sound_file_entry.save

      puts "imported #{entry}"
    end
  end
end