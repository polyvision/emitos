class CallBox < ActiveRecord::Migration
  def up
    add_column :call_boxes, :call_one_type,:integer, :default => 0
    add_column :call_boxes, :call_one_notification_number,:string

    add_column :call_boxes, :call_two_type, :integer, :default => 0
    add_column :call_boxes, :call_two_notification_number,:string

    add_column :call_boxes, :call_three_type, :integer, :default => 0
    add_column :call_boxes, :call_three_notification_number, :string

    add_column :call_boxes, :jingle_file_id, :integer
  end

  def down
  end
end
