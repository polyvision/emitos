class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_controller

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end


  def current_controller()
    @current_controller = request.env['action_dispatch.request.path_parameters'][:controller]
  end
end
