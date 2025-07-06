class CreateUserProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.string :first_name
      t.string :last_name
      t.string :display_name
      t.string :phone
      t.text :bio
      t.string :avatar_url
      t.json :metadata

      t.timestamps
    end

    add_index :user_profiles, :user_id, unique: true
  end
end