class CreateMarketingCalls < ActiveRecord::Migration
  def change
    create_table :marketing_calls do |t|

      t.timestamps
      t.text  :day_matrix
      t.boolean :use_matrix
      t.integer :minutes_pro_call
      t.string :name
      t.time  :play_at
      t.integer :sound_file_id
    end
  end
end