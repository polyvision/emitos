class CreateCallBoxStatistics < ActiveRecord::Migration
  def change
    create_table :call_box_statistics do |t|

      t.timestamps
      t.integer :call_box_id
      t.integer :state, :default => 1
      t.integer :num_call, :default => 1
    end
  end
end