class CallboxController < ApplicationController
	def index
		@call_box_prototype = CallBox.new

		@call_boxes = CallBox.all
	end

	def create
		@call_box = CallBox.new(params[:call_box])
		@call_box.save
		redirect_to :action => 'index'
	end

	def edit
		@call_box = CallBox.find(params[:id])
		render :layout => false
	end

	def update
		@call_box = CallBox.find(params[:id])
		@call_box.update_attributes(params[:call_box])
		redirect_to :action => 'index'
	end

	def test_sound
		@call_box = CallBox.find(params[:id])
		
		@call_box.play_sound_on_psd

		respond_to do |format|
			format.js
		end
	end
end
