class User < ApplicationRecord
  has_many :chats, inverse_of: :user
end
