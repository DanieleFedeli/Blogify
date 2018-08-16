class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
         
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  mount_uploader :avatar, AvatarUploader
  
  attr_writer :login

  def login
    @login || self.username || self.email
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # Ritorna tutti gli amici suggeriti.
  #   Condizioni:
  #     Followers in comune
  #     Following in comune
  # RELATIONSHIPS X RELAZIONI DELL'UTENTE IN QUESTIONE
  # RELATIONSHIPS Y RELAZIONI DI ALTRI UTENTI
  # FOLLOWED_ID: COLUI CHE E' SEGUITO
  # FOLLOWER_ID: COLUI CHE SEGUE
  def suggested_friends
    User.find_by_sql(["    
    SELECT users.*, count(*) as common_follower, y.followed_id
    FROM relationships x INNER JOIN relationships y
    ON x.follower_id = ? AND y.follower_id <> x.follower_id AND y.follower_id = x.followed_id, users
    WHERE users.id <> ? AND users.id = y.followed_id
    AND y.followed_id NOT IN (SELECT followed_id FROM relationships WHERE follower_id = ?)
    GROUP BY y.followed_id, users.id
    ORDER BY common_follower DESC
    ", id, id, id])
  end

  def tag_in_common_friends
    User.find_by_sql(['
      WITH used_tags AS(
        SELECT tags.name, posts.user_id AS author
        FROM taggings JOIN tags ON tags.id = tag_id
        JOIN posts on taggable_id = posts.id
      )
        
        SELECT users.*, count(used_tags.name) as common_tags
        FROM used_tags JOIN users on users.id = author
        WHERE users.id <> ? AND used_tags.name IN (
        SELECT tags.name 
        FROM taggings JOIN tags ON tags.id = tag_id 
        JOIN posts on taggable_id = posts.id
        JOIN users on user_id = users.id AND users.id = ?) AND
        users.id NOT IN (SELECT followed_id FROM relationships WHERE follower_id = ?)
        GROUP BY users.id
        HAVING count(used_tags.name) >=15
        ORDER BY count(used_tags.name) DESC      
    ',id, id, id])
  end
  def feed
    following_ids = "SELECT followed_id FROM relationships 
                     WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
      user.remote_url = auth.info.image
    end
  end
  
end
