class Group < ApplicationRecord
  belongs_to :user
  has_many :group_users
  has_many :joineds, through: :group_users, source: :user

  validates :name, presence: true, length: { maximum: 15 }
end
