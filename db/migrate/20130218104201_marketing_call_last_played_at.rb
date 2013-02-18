class MarketingCallLastPlayedAt < ActiveRecord::Migration
  def up
	add_column :marketing_calls, :last_played_at, :datetime
  end

  def down
  end
end
