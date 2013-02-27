class CreateCallBoxNotifications < ActiveRecord::Migration
  def change
    create_table :call_box_notifications do |t|

      t.timestamps
      t.string :msg
      t.string :send_to
      t.integer :response_code
      t.integer :response_msg_id
      t.float :response_cost
      t.integer :sms_count
    end
  end
end
