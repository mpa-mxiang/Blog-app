# spec/models/like_spec.rb

require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0, author: user)
    like = Like.new(user: user, post: post)
    expect(like).to be_valid
  end

  it 'is invalid without a user' do
    post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0)
    like = Like.new(post: post)
    expect(like).to_not be_valid
  end

  it 'is invalid without a post' do
    user = User.create(name: 'John', posts_counter: 0)
    like = Like.new(user: user)
    expect(like).to_not be_valid
  end

  it 'increments the post\'s likes_counter when a like is created' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0, author: user)

    expect do
      Like.create(user: user, post: post)
      post.reload
    end.to change(post, :likes_counter).by(1)
  end
end
