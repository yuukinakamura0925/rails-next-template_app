class Api::V1::HealthController < ApplicationController
  # Skip authentication for health check
  skip_before_action :authenticate_user!, if: :skip_auth?
  
  def show
    render json: {
      status: 'OK',
      message: 'Rails API is running',
      timestamp: Time.current.iso8601,
      version: '1.0.0',
      environment: Rails.env
    }
  end
  
  private
  
  def skip_auth?
    true
  end
  
  def authenticate_user!
    # Override base authentication for health check
  end
end