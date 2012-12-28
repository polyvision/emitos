class CreateSoundFiles < ActiveRecord::Migration
  def change
    create_table :sound_files do |t|

      t.timestamps
      t.string :file
      t.integer :sound_group_id
    end
  end
end