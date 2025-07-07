# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Seeding database..."

# Admin user for development
if Rails.env.development?
  admin_user = User.find_or_create_by(firebase_uid: 'dev-admin-uid') do |user|
    user.email = 'admin@example.com'
    user.role = 'admin'
    user.active = true
  end

  # UserProfileにデータを設定
  admin_user.user_profile.update!(
    first_name: 'Admin',
    last_name: 'User',
    display_name: 'システム管理者',
    bio: '開発用の管理者アカウントです',
    metadata: {
      development: true,
      created_by: 'seed'
    }
  )

  puts "✅ Admin user created: #{admin_user.email}"

  # Sample user for development
  sample_user = User.find_or_create_by(firebase_uid: 'dev-user-uid') do |user|
    user.email = 'user@example.com'
    user.role = 'user'
    user.active = true
  end

  # UserProfileにデータを設定
  sample_user.user_profile.update!(
    first_name: 'サンプル',
    last_name: 'ユーザー',
    display_name: 'sample_user',
    phone: '090-1234-5678',
    bio: 'これはサンプルユーザーです。開発・テスト用のアカウントです。',
    metadata: {
      development: true,
      created_by: 'seed',
      preferences: {
        language: 'ja',
        timezone: 'Asia/Tokyo'
      }
    }
  )
  
  puts "✅ Sample user created: #{sample_user.email}"
end

puts "🎉 Seeding completed!"
puts ""
puts "Created users:"
User.all.each do |user|
  puts "  - #{user.email} (#{user.role}) - #{user.display_name}"
end
