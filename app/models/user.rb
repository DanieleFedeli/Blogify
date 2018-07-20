class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login]
         
  has_many :posts
  has_many :pending_posts
  has_many :refused_posts
  has_many :comments

  attr_writer :login

  def login
    @login || self.username || self.email
  end
end
