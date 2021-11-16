class Group < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 15 }
end
