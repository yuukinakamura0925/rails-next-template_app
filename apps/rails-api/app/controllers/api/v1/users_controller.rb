class Api::V1::UsersController < Api::V1::BaseController
  # GET /api/v1/users/current - 現在のユーザー情報取得
  def show
    render_success({
      user: user_json(current_user),
      profile: profile_json(current_user.user_profile)
    }, 'User information retrieved successfully')
  end

  # PATCH /api/v1/users/current - 現在のユーザー情報更新
  def update
    if current_user.update(user_params)
      render_success({
        user: user_json(current_user),
        profile: profile_json(current_user.user_profile)
      }, 'User updated successfully')
    else
      render_error('Failed to update user', :unprocessable_entity)
    end
  end

  # DELETE /api/v1/users/current - 現在のユーザー無効化
  def destroy
    current_user.deactivate!
    render_success({}, 'User deactivated successfully')
  end

  private

  # ユーザー更新用パラメータ
  def user_params
    params.require(:user).permit(:email)
  end

  # ユーザーJSON形式
  def user_json(user)
    {
      id: user.id,
      email: user.email,
      role: user.role,
      active: user.active,
      display_name: user.display_name,
      full_name: user.full_name,
      avatar_url: user.avatar_url,
      created_at: user.created_at,
      updated_at: user.updated_at
    }
  end

  # プロフィールJSON形式
  def profile_json(profile)
    return nil unless profile

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