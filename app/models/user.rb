class User < ApplicationRecord
  has_many :posts
  validates :username, presence: true, uniqueness: true, length: {minimum: 4, maximum: 25}
  validates :email, presence: true, uniqueness: true, format: {with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
end
