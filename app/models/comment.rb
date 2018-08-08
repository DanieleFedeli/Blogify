class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user, presence: true
  validates :post, presence: true
  validates :body, presence: true

  default_scope -> { order(created_at: :desc)}
end
