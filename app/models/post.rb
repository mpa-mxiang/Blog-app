class Post < ApplicationRecord
  belongs_to :authorId
  has_many :comments
  has_many :likes
end
