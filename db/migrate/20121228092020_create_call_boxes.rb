class CreateCallBoxes < ActiveRecord::Migration
  def change
    create_table :call_boxes do |t|

      t.timestamps
      t.string	:name
      t.string	:mac
    end
  end
end
