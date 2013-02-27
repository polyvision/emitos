class SettingMobilant < ActiveRecord::Migration
  def up
    Setting.new(:name => 'MOBILANT_ROUTE',:value => "lowcost").save
  end

  def down
  end
end
