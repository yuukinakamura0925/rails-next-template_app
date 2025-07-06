class User < ApplicationRecord
  # Associations
  has_one :user_profile, dependent: :destroy

  # Validations
  validates :firebase_uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: %w[user admin] }

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :by_role, ->(role) { where(role: role) }
  scope :users, -> { where(role: 'user') }
  scope :admins, -> { where(role: 'admin') }

  # Class methods
  def self.find_or_create_by_firebase(firebase_uid:, email:, role: 'user')
    find_or_create_by(firebase_uid: firebase_uid) do |user|
      user.email = email
      user.role = role
      user.active = true
    end
  end

  # Instance methods
  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end

  def deactivate!
    update!(active: false)
  end

  def activate!
    update!(active: true)
  end

  def full_name
    return display_name if user_profile&.display_name.present?
    return "#{user_profile.first_name} #{user_profile.last_name}" if user_profile&.first_name.present?
    email.split('@').first
  end

  def display_name
    user_profile&.display_name || full_name
  end

  def avatar_url
    user_profile&.avatar_url
  end

  # Callbacks
  after_create :create_user_profile

  private

  def create_user_profile
    UserProfile.create!(user: self) unless user_profile.present?
  end
end