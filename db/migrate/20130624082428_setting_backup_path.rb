class SettingBackupPath < ActiveRecord::Migration
  def up
    Setting.new(:name => 'BACKUP_DIRECTORY',:value => "/home/backups/").save
  end

  def down
  end
end
