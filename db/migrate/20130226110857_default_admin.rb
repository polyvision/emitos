class DefaultAdmin < ActiveRecord::Migration
  def up
    User.first.add_role('Admin')
  end

  def down
  end
end
