class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, charset: :ascii, limit: 128, index: { unique: true }
      t.string :name
      t.string :encrypted_password, charset: :ascii, limit: 128, null: false, default: ''

      ## Recoverable
      t.string :reset_password_token, charset: :ascii, limit: 128, index: { unique: true }
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token, charset: :ascii, limit: 128, index: { unique: true }
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token, charset: :ascii, limit: 128, index: { unique: true }
      # t.datetime :locked_at

      # Uncomment below if timestamps were not included in your original model.
      t.timestamps
    end

    create_table :chats do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.timestamps
    end

    create_table :messages do |t|
      t.references :chat, foreign_key: true
      t.integer :role
      t.text :content
      t.timestamps
    end
  end
end
