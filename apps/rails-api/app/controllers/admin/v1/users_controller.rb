class Admin::V1::UsersController < Admin::V1::BaseController
  before_action :set_user, only: [:show, :update, :destroy, :activate]

  # GET /admin/v1/users - ユーザー一覧取得
  def index
    users = User.includes(:user_profile)
                .page(params[:page] || 1)
                .per(params[:per_page] || 20)

    # 役割でフィルタ（指定されている場合）
    users = users.by_role(params[:role]) if params[:role].present?

    # アクティブ状態でフィルタ（指定されている場合）
    users = users.where(active: params[:active]) if params[:active].present?

    # メールまたは表示名で検索
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      users = users.joins(:user_profile)
                   .where(
                     "users.email ILIKE ? OR user_profiles.display_name ILIKE ? OR user_profiles.first_name ILIKE ? OR user_profiles.last_name ILIKE ?",
                     search_term, search_term, search_term, search_term
                   )
    end

    render_success({
      users: users.map { |user| admin_user_json(user) },
      pagination: {
        current_page: users.current_page,
        total_pages: users.total_pages,
        total_count: users.total_count,
        per_page: users.limit_value
      }
    }, 'Users retrieved successfully')
  end

  # GET /admin/v1/users/:id - ユーザー詳細取得
  def show
    render_success({
      user: admin_user_json(@user)
    }, 'User retrieved successfully')
  end

  # POST /admin/v1/users - ユーザー作成
  def create
    user = User.new(user_create_params)

    if user.save
      render_success({
        user: admin_user_json(user)
      }, 'User created successfully')
    else
      render_error("Failed to create user: #{user.errors.full_messages.join(', ')}", :unprocessable_entity)
    end
  end

  # PATCH /admin/v1/users/:id - ユーザー情報更新
  def update
    if @user.update(user_update_params)
      render_success({
        user: admin_user_json(@user)
      }, 'User updated successfully')
    else
      render_error("Failed to update user: #{@user.errors.full_messages.join(', ')}", :unprocessable_entity)
    end
  end

  # DELETE /admin/v1/users/:id - ユーザー無効化
  def destroy
    @user.deactivate!
    render_success({
      user: admin_user_json(@user)
    }, 'User deactivated successfully')
  end

  # POST /admin/v1/users/:id/activate - ユーザー有効化
  def activate
    @user.activate!
    render_success({
      user: admin_user_json(@user)
    }, 'User activated successfully')
  end

  # GET /admin/v1/users/stats - ユーザー統計情報取得
  def stats
    render_success({
      total_users: User.count,
      active_users: User.active.count,
      inactive_users: User.inactive.count,
      admin_users: User.admins.count,
      regular_users: User.users.count,
      users_with_complete_profiles: User.joins(:user_profile).where('user_profiles.first_name IS NOT NULL AND user_profiles.last_name IS NOT NULL').count
    }, 'User statistics retrieved successfully')
  end

  private

  # ユーザーを取得（共通処理）
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_error('User not found', :not_found)
  end

  # ユーザー作成用パラメータ
  def user_create_params
    params.require(:user).permit(:firebase_uid, :email, :role)
  end

  # ユーザー更新用パラメータ
  def user_update_params
    params.require(:user).permit(:email, :role, :active)
  end

  # 管理者向けユーザーJSON形式
  def admin_user_json(user)
    {
      id: user.id,
      firebase_uid: user.firebase_uid,
      email: user.email,
      role: user.role,
      active: user.active,
      display_name: user.display_name,
      full_name: user.full_name,
      avatar_url: user.avatar_url,
      created_at: user.created_at,
      updated_at: user.updated_at,
      profile: user.user_profile ? admin_profile_json(user.user_profile) : nil
    }
  end

  # 管理者向けプロフィールJSON形式
  def admin_profile_json(profile)
    {
      id: profile.id,
      first_name: profile.first_name,
      last_name: profile.last_name,
      display_name: profile.display_name,
      phone: profile.phone,
      bio: profile.bio,
      avatar_url: profile.avatar_url,
      metadata: profile.metadata,
      profile_completion: profile.profile_completion_percentage,
      created_at: profile.created_at,
      updated_at: profile.updated_at
    }
  end
end