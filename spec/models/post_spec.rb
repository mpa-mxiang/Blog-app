require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.new(
      title: 'Title',
      comments_counter: 0,
      likes_counter: 0,
      author: user
    )
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.new(
      comments_counter: 0,
      likes_counter: 0,
      author: user
    )
    expect(post).to_not be_valid
  end

  it 'is invalid with a title exceeding 250 characters' do
    user = User.create(name: 'John', posts_counter: 0)
    title = 'a' * 251
    post = Post.new(
      title: title,
      comments_counter: 0,
      likes_counter: 0,
      author: user
    )
    expect(post).to_not be_valid
  end

  it 'is invalid with a negative comments_counter' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.new(
      title: 'Title',
      comments_counter: -1,
      likes_counter: 0,
      author: user
    )
    expect(post).to_not be_valid
  end

  it 'is invalid with a negative likes_counter' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.new(
      title: 'Title',
      comments_counter: 0,
      likes_counter: -1,
      author: user
    )
    expect(post).to_not be_valid
  end

  it 'is valid with nil comments_counter and likes_counter' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.new(
      title: 'Title',
      comments_counter: nil,
      likes_counter: nil,
      author: user
    )
    expect(post).to be_valid
  end

  it 'is invalid without an author' do
    post = Post.new(
      title: 'Title',
      comments_counter: 0,
      likes_counter: 0
    )
    expect(post).to_not be_valid
  end
end
