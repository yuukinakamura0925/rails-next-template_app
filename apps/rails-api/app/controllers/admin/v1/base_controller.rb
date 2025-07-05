class Admin::V1::BaseController < ApplicationController
  before_action :authenticate_admin!
  
  protected
  
  def authenticate_admin!
    # Firebase admin token authentication will be implemented here
    # For now, just return true for development
    return true if Rails.env.development?
    
    # TODO: Implement Firebase ID token verification with admin role check
    render json: { error: 'Unauthorized - Admin access required' }, status: :unauthorized
  end
  
  def current_admin
    # TODO: Return current admin user from Firebase token
    @current_admin ||= nil
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