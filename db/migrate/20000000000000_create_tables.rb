class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, charset: :ascii, limit: 128, index: { unique: true }
      t.string :name
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
