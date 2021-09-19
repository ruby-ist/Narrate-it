class Comment < ApplicationRecord
  belongs_to :post

  validates :name,presence: true
  validates :comment, presence: true, length: {minimum: 3}
end
