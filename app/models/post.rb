class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :likeds, through: :favorites, source: :user
  
  validates :content, presence: true, length: { maximum: 140 }
end
