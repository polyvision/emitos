class MoreSettings < ActiveRecord::Migration
  def up
	Setting.new(:name => 'MOBILANT_API_KEY').save
	Setting.new(:name => 'TIME_BETWEEN_CALLBOX_NOTIFICATION',:value => 60).save
  end

  def down
  end
end
