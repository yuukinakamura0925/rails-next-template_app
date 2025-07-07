class Api::V1::UserProfilesController < Api::V1::BaseController
  before_action :set_profile

  # GET /api/v1/user_profiles/current - 現在のユーザープロフィール取得
  def show
    render_success(profile_json(@profile), 'Profile retrieved successfully')
  end

  # PATCH /api/v1/user_profiles/current - 現在のユーザープロフィール更新
  def update
    if @profile.update(profile_params)
      render_success(profile_json(@profile), 'Profile updated successfully')
    else
      render_error('Failed to update profile', :unprocessable_entity)
    end
  end

  # PATCH /api/v1/user_profiles/current/metadata - プロフィールメタデータ更新
  def update_metadata
    if metadata_params.present?
      @profile.merge_metadata(metadata_params.to_h)
      @profile.save!
      render_success(profile_json(@profile), 'Metadata updated successfully')
    else
      render_error('No metadata provided', :bad_request)
    end
  end

  # DELETE /api/v1/user_profiles/current/metadata/:key - プロフィールメタデータ削除
  def delete_metadata
    key = params[:key]
    if key.present? && @profile.metadata&.key?(key)
      metadata = @profile.metadata.dup
      metadata.delete(key)
      @profile.update!(metadata: metadata)
      render_success(profile_json(@profile), 'Metadata key deleted successfully')
    else
      render_error('Metadata key not found', :not_found)
    end
  end

  private

  # 現在のユーザーのプロフィールを設定
  def set_profile
    @profile = current_user.user_profile
  end

  # プロフィール更新用パラメータ
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :display_name, :phone, :bio, :avatar_url)
  end

  # メタデータ更新用パラメータ
  def metadata_params
    params.require(:metadata).permit! if params[:metadata].present?
  end

  # プロフィールJSON形式
  def profile_json(profile)
    {
      id: profile.id,
      user_id: profile.user_id,
      first_name: profile.first_name,
      last_name: profile.last_name,
      display_name: profile.display_name,
      phone: profile.phone,
      bio: profile.bio,
      avatar_url: profile.avatar_url,
      metadata: profile.metadata,
      full_name: profile.full_name,
      name_for_display: profile.name_for_display,
      has_basic_info: profile.has_basic_info?,
      profile_completion: profile.profile_completion_percentage,
      created_at: profile.created_at,
      updated_at: profile.updated_at
    }
  end
end