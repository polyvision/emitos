class Setting < ActiveRecord::Base
  attr_accessible :name, :value

  def self.get_val(name)
  	return Setting.find_by_name(name).value
  end
end
