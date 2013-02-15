class CallBoxMaxCalls < ActiveRecord::Migration
  def up
    add_column :call_boxes,:max_calls, :integer, :default => 3
  end

  def down
  end
end
