require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'John')
    post = Post.create(title: 'Title', author: user)
    comment = Comment.new(user: user, post: post, text: 'Valid comment text')
    expect(comment).to be_valid
  end
  it 'is invalid without text' do
    user = User.create(name: 'John')
    post = Post.create(title: 'Title', author: user)
    comment = Comment.new(user: user, post: post, text: nil) # Provide nil text to trigger the validation error
    expect(comment).to_not be_valid
  end
  
  it 'increments the post comments_counter after creation' do
    user = User.create(name: 'John')
    post = Post.create(title: 'Title', author: user)
  
    expect {
      comment = Comment.create(user: user, post: post, text: 'Increment test')
      post.reload # Reload the post to get the updated comments_counter
    }.to change { post.reload.comments_counter }.by(1)
  end
  
end
