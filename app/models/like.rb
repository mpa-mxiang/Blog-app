class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

def update_likes_count
  update(likes_count: likes.count)
end
end