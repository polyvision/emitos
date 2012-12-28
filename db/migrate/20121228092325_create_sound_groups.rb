class CreateSoundGroups < ActiveRecord::Migration
  def change
    create_table :sound_groups do |t|

      t.timestamps
      t.string :name
    end

    SoundGroup.new(:name => 'Stationen').save
    SoundGroup.new(:name => 'Werbung').save
  end
end
