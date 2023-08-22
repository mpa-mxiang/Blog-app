require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'John')
    post = Post.create(title: 'Title', author: user)
    comment = Comment.new(user: user, post: post, text: 'Valid comment text')
    expect(comment).to be_valid
  end

  it 'is invalid without a user' do
    post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0)
    comment = Comment.new(post: post, text: 'Invalid comment')
    expect(comment).to_not be_valid
  end

  it 'is invalid without a post' do
    user = User.create(name: 'John', posts_counter: 0)
    comment = Comment.new(user: user, text: 'Invalid comment')
    expect(comment).to_not be_valid
  end
  
  it 'increments the comments_counter of the associated post after creating a comment' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0, author: user)

    expect {
      comment = post.comments.create(user: user, text: 'New Comment')
    }.to change { post.reload.comments_counter }.by(1)
  end

  it 'does not increment comments_counter if the comment creation fails' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0, author: user)

    expect {
      comment = post.comments.create(user: nil, text: 'Invalid Comment')
    }.not_to change { post.reload.comments_counter }
  end
  
end
