class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|

      t.timestamps
      t.string	:name
      t.string  :value
    end

    Setting.new(:name => 'ESD_HOST',:value => 'localhost').save
    Setting.new(:name => 'PSD_PORT',:value => '8823').save
  end
end
