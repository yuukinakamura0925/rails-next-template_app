class CreateUserProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }, index: { unique: true }
      t.string :first_name
      t.string :last_name
      t.string :display_name
      t.string :phone
      t.text :bio
      t.string :avatar_url
      t.json :metadata

      t.timestamps
    end
  end
end