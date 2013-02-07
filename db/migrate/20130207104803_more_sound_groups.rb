class MoreSoundGroups < ActiveRecord::Migration
  def up
    SoundGroup.new(:name => 'Jingles').save
  end

  def down
  end
end
