class CreateCallBoxStatistics < ActiveRecord::Migration
  def change
    create_table :call_box_statistics do |t|

      t.timestamps
    end
  end
end
