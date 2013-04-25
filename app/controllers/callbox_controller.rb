class CallboxController < ApplicationController
  before_filter :authenticate_user!

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

  def delete
    @call_box = CallBox.destroy

    redirect_to :action => 'index'
  end

	def test_sound
		@call_box = CallBox.find(params[:id])
		
		@call_box.play_sound_on_psd

		respond_to do |format|
			format.js
		end
  end

  def test_activate
    @call_box = CallBox.find(params[:id])

    #http://localhost:3000/api/callbox/activate/666-7777
    call_url = "#{request.protocol}#{request.host_with_port}/api/callbox/activate/#{@call_box.mac}"
    puts "trying to activate via #{call_url}"
    http = Curl.get(call_url)
    @call_result = http.body_str
    puts http.body_str

    respond_to do |format|
      format.js
    end
  end

  def test_deactivate
    @call_box = CallBox.find(params[:id])

    call_url = "#{request.protocol}#{request.host_with_port}/api/callbox/deactivate/#{@call_box.mac}"
    puts "trying to deactivate via #{call_url}"
    http = Curl.get(call_url)
    @call_result = http.body_str
    puts http.body_str

    respond_to do |format|
      format.js
    end
  end
end
