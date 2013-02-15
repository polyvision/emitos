class SoundFilesMany < ActiveRecord::Migration
  def up
    SoundGroup.new(:name => 'Marktdurchsagen').save

    load "#{Rails.root}/lib/import.rb"
    Import.process(SoundGroup.find(1),"#{Rails.root}/3rd/Rufdurchsagen/*")

    Import.process(SoundGroup.find(3),"#{Rails.root}/3rd/jingles/*")

    Import.process(SoundGroup.find(4),"#{Rails.root}/3rd/Geschaeftsdurchsagen/*")
  end

  def down
  end
end
