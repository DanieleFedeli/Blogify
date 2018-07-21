class PendingPost < ApplicationRecord
  has_many :comments
  belongs_to :user

  acts_as_taggable

  validates :title, presence: true, length: { in: 3..32}
  validates :body, presence: true, length:  {minimum: 128 }
end
