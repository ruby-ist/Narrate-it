class Post < ApplicationRecord
  has_many :comments

  validates :title, presence: true, length: {minimum: 3, maximum: 25}
  validates :body, presence: true
end
