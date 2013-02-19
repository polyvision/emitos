class SoundfileController < ApplicationController
  before_filter :authenticate_user!

	def index
		@sound_file_prototype = SoundFile.new

		@sound_files = SoundFile.all
	end

	def create
		@sound_file = SoundFile.new(params[:sound_file])
		@sound_file.save
		redirect_to :action => 'index'
	end

	def delete
		@soundfile = SoundFile.find(params[:id])		
		@soundfile.destroy
		redirect_to :action => 'index'
	end
end