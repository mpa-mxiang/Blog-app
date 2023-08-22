require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and a non-negative integer posts_counter' do
    user = User.new(name: 'John', posts_counter: 0)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(posts_counter: 0)
    expect(user).to_not be_valid
  end

  it 'is invalid with a negative posts_counter' do
    user = User.new(name: 'John', posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'is valid with a nil posts_counter' do
    user = User.new(name: 'John', posts_counter: nil)
    expect(user).to be_valid
  end
  describe '#recent_posts' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'John', posts_counter: 0)

      # Create posts for the user
      user.posts.create(title: 'Post 1', text: 'Text 1')
      post2 = user.posts.create(title: 'Post 2', text: 'Text 2')
      post3 = user.posts.create(title: 'Post 3', text: 'Text 3')
      post4 = user.posts.create(title: 'Post 4', text: 'Text 4')

      # Ensure the method returns the 3 most recent posts
      recent_posts = user.recent_posts
      expect(recent_posts).to eq([post4, post3, post2])
    end

    it 'returns fewer than 3 posts if the user has fewer posts' do
      user = User.create(name: 'John', posts_counter: 0)

      # Create only 2 posts for the user
      post1 = user.posts.create(title: 'Post 1', text: 'Text 1')
      post2 = user.posts.create(title: 'Post 2', text: 'Text 2')

      # Ensure the method returns all available posts (2 in this case)
      recent_posts = user.recent_posts
      expect(recent_posts).to eq([post2, post1])
    end
  end
end
