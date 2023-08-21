require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }

  describe '#recent_posts' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'Example User', posts_counter: 2)

      # Create some posts associated with the user
      post1 = user.posts.create(title: 'Post 1', text: 'Text 1')
      post2 = user.posts.create(title: 'Post 2', text: 'Text 2')
      post3 = user.posts.create(title: 'Post 3', text: 'Text 3')
      post4 = user.posts.create(title: 'Post 4', text: 'Text 4')

      # Ensure the method returns the most recent posts
      expect(user.recent_posts).to eq([post4, post3, post2])
    end

    it 'returns fewer than 3 posts if the user has fewer than 3 posts' do
      user = User.create(name: 'Another User', posts_counter: 1)
      post1 = user.posts.create(title: 'Post 1', text: 'Text 1')

      # Ensure the method returns the only post available
      expect(user.recent_posts).to eq([post1])
    end

    it 'returns an empty array if the user has no posts' do
      user = User.create(name: 'Empty User', posts_counter: 0)

      # Ensure the method returns an empty array
      expect(user.recent_posts).to eq([])
    end
  end
end
