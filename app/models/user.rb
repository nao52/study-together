class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :goal, length: { maximum: 255 }
  validates :status, length: { maximum: 255 }
  
  has_many :posts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favorites
  has_many :likes, through: :favorites, source: :post
  has_many :groups
  has_many :group_users
  has_many :joinings, through: :group_users, source: :group
  has_many :group_posts

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_posts
    Post.where(user_id: self.following_ids)
  end
  
  def favorite(post)
    self.favorites.find_or_create_by(post_id: post.id)
  end

  def unfavorite(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end

  def likes?(post)
    self.likes.include?(post)
  end
  
  def join(group)
    self.group_users.find_or_create_by(group_id: group.id)
  end
  
  def unjoin(group)
    join = self.group_users.find_by(group_id: group.id)
    join.destroy if join
  end
  
  def joinings?(group)
    self.joinings.include?(group)
  end
end