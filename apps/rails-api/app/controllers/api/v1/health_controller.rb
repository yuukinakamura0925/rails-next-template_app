class Api::V1::HealthController < ApplicationController

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

end