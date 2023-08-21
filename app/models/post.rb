class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

after_create :increment_user_posts_count

private

def increment_user_posts_count
  user.increment!(:posts_count)
end
def recent_comments
  comments.order(created_at: :desc).limit(5)
end
end