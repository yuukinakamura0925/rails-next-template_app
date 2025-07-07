class Admin::V1::BaseController < ApplicationController
  before_action :authenticate_admin!

  protected

  def authenticate_admin!
    # Firebase管理者トークン認証をここに実装予定
    # 現在は開発環境では認証をスキップ
    return true if Rails.env.development?

    # TODO: Firebase IDトークン検証と管理者権限チェックを実装
    render json: { error: 'Unauthorized - Admin access required' }, status: :unauthorized
  end

  def current_admin
    # TODO: Firebaseトークンから現在の管理者ユーザーを取得
    # 開発環境では最初の管理者ユーザーを返す
    @current_admin ||= User.admins.first if Rails.env.development?
  end

  def current_user
    current_admin
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