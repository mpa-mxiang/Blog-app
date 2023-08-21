require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(250) }
  it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }

  describe '#increment_user_posts_count' do
    it 'increments the user\'s posts_count' do
      user = User.create(name: 'Example User', posts_counter: 0)
      post = user.posts.create(title: 'New Post', comments_counter: 0, likes_counter: 0)

      # Ensure the user's posts_count is incremented after creating a post
      expect(user.reload.posts_counter).to eq(1)
    end
  end

  describe '#recent_comments' do
    it 'returns the 5 most recent comments' do
      post = Post.create(title: 'Sample Post', comments_counter: 0, likes_counter: 0)

      # Create some comments associated with the post
      comment1 = post.comments.create(text: 'Comment 1')
      comment2 = post.comments.create(text: 'Comment 2')
      comment3 = post.comments.create(text: 'Comment 3')
      comment4 = post.comments.create(text: 'Comment 4')
      comment5 = post.comments.create(text: 'Comment 5')
      comment6 = post.comments.create(text: 'Comment 6')

      # Ensure the method returns the most recent comments (limited to 5)
      expect(post.recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end

    it 'returns fewer than 5 comments if the post has fewer than 5 comments' do
      post = Post.create(title: 'Another Post', comments_counter: 0, likes_counter: 0)

      # Create only 2 comments associated with the post
      comment1 = post.comments.create(text: 'Comment 1')
      comment2 = post.comments.create(text: 'Comment 2')

      # Ensure the method returns the available comments
      expect(post.recent_comments).to eq([comment2, comment1])
    end

    it 'returns an empty array if the post has no comments' do
      post = Post.create(title: 'Empty Post', comments_counter: 0, likes_counter: 0)

      # Ensure the method returns an empty array
      expect(post.recent_comments).to eq([])
    end
  end
end
