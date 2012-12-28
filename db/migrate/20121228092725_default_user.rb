class DefaultUser < ActiveRecord::Migration
  def up
  	default_user = User.new
  	default_user.email = "admin@emitos.de"
  	default_user.password = "defaultpw"
  	default_user.password_confirmation = "defaultpw"
  	default_user.name = "admin"
	default_user.save
  end

  def down
  end
end
