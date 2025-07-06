class UserProfile < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :user_id, presence: true, uniqueness: true
  validates :phone, format: { with: /\A[\d\-+\(\)\s]+\z/, message: 'は有効な電話番号を入力してください' }, allow_blank: true

  # Callbacks
  before_save :sanitize_phone

  # Instance methods
  def full_name
    return display_name if display_name.present?
    return "#{first_name} #{last_name}".strip if first_name.present? || last_name.present?
    nil
  end

  def name_for_display
    full_name || user.email.split('@').first
  end

  def has_basic_info?
    first_name.present? || last_name.present? || display_name.present?
  end

  def profile_completion_percentage
    total_fields = 7 # first_name, last_name, display_name, phone, bio, avatar_url, metadata
    completed_fields = 0

    completed_fields += 1 if first_name.present?
    completed_fields += 1 if last_name.present?
    completed_fields += 1 if display_name.present?
    completed_fields += 1 if phone.present?
    completed_fields += 1 if bio.present?
    completed_fields += 1 if avatar_url.present?
    completed_fields += 1 if metadata.present? && metadata.any?

    (completed_fields.to_f / total_fields * 100).round
  end

  # メタデータの便利メソッド
  def get_metadata(key)
    metadata&.dig(key.to_s)
  end

  def set_metadata(key, value)
    self.metadata = {} if metadata.nil?
    self.metadata[key.to_s] = value
  end

  def merge_metadata(hash)
    self.metadata = (metadata || {}).merge(hash.stringify_keys)
  end

  private

  def sanitize_phone
    return unless phone.present?

    # 電話番号から数字とハイフンのみを残す
    self.phone = phone.gsub(/[^\d\-]/, '')
  end
end