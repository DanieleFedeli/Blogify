class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :user

  acts_as_taggable

  validates :title, presence: true, length: { in: 3..32}  
  validates :body, presence: true, length: { minimum: 128 }

  default_scope -> { order(created_at: :desc)}
end
