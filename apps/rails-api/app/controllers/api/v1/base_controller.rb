class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user!
  
  protected
  
  def authenticate_user!
    # Firebase token authentication will be implemented here
    # For now, just return true for development
    return true if Rails.env.development?
    
    # TODO: Implement Firebase ID token verification
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
  
  def current_user
    # TODO: Return current user from Firebase token
    @current_user ||= nil
  end
  
  def render_success(data = {}, message = 'Success')
    render json: {
      success: true,
      message: message,
      data: data
    }
  end
  
  def render_error(message = 'Error', status = :bad_request)
    render json: {
      success: false,
      message: message,
      errors: []
    }, status: status
  end
end