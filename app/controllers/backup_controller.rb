class BackupController < ApplicationController
  before_filter :authenticate_user!

  def index
    entries = Dir["#{Setting.get_val("BACKUP_DIRECTORY")}/*"]
    @fentries = Array.new
    entries.each do |entry|
      @fentries << File.new(entry)
    end
  end

  def download
    path = "#{Setting.get_val("BACKUP_DIRECTORY")}/#{params[:fe]}"
    send_file(path)
  end
end
