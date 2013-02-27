class CallBoxNoRoute < ActiveRecord::Migration
  def up
    add_column :call_box_notifications, :sms_route, :string
  end

  def down
  end
end
