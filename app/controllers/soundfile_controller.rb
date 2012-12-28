class SoundfileController < ApplicationController

	def index
		@sound_file_prototype = SoundFile.new

		@sound_files = SoundFile.all
	end

	def create
		@sound_file = SoundFile.new(params[:sound_file])
		@sound_file.save
		redirect_to :action => 'index'
	end
end