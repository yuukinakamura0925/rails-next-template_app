class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :firebase_uid, null: false
      t.string :email, null: false
      t.string :role, null: false, default: 'user'
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :users, :firebase_uid, unique: true
    add_index :users, :email, unique: true
    add_index :users, :role
    add_index :users, :active
  end
end