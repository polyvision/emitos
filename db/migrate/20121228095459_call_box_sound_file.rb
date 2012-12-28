class CallBoxSoundFile < ActiveRecord::Migration
  def up
  	add_column :call_boxes,:sound_file_id, :integer
  end

  def down
  end
end
