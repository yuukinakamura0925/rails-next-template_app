class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user!

  protected

  def authenticate_user!
    # Firebaseトークン認証をここに実装予定
    # 現在は開発環境では認証をスキップ
    return true if Rails.env.development?

    # TODO: Firebase IDトークン検証を実装
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def current_user
    # TODO: Firebaseトークンから現在のユーザーを取得
    # 開発環境では最初のユーザーを返す
    @current_user ||= User.first if Rails.env.development?
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