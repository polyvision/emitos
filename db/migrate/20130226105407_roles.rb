class Roles < ActiveRecord::Migration
  def up
    Role.new(:name => 'Admin').save
    Role.new(:name => 'Statistic').save
    Role.new(:name => 'SoundFiles').save
    Role.new(:name => 'CallBox').save
    Role.new(:name => 'MarketSettings').save
    Role.new(:name => 'MarketCalls').save
  end

  def down
  end
end
