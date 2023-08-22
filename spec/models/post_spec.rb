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
  describe '#increment_user_posts_count' do
  it 'increments the user\'s posts_counter' do
    user = User.create(name: 'John', posts_counter: 0)
    post = Post.create(
      title: 'Title',
      comments_counter: 0,
      likes_counter: 0,
      author: user
    )

    expect {
      post.send(:increment_user_posts_count) # Use send to invoke private method
    }.to change { user.reload.posts_counter }.by(1)
  end
end
describe '#recent_comments' do
it 'returns the 5 most recent comments for the post' do
  user = User.create(name: 'John', posts_counter: 0)
  post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0, author: user)
  
  # Create comments for the post
  comment1 = post.comments.create(user: user, text: 'Comment 1')
  comment2 = post.comments.create(user: user, text: 'Comment 2')
  comment3 = post.comments.create(user: user, text: 'Comment 3')
  comment4 = post.comments.create(user: user, text: 'Comment 4')
  comment5 = post.comments.create(user: user, text: 'Comment 5')
  comment6 = post.comments.create(user: user, text: 'Comment 6')
  
  expect(post.recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
end


it 'returns fewer than 5 comments if the post has fewer comments' do
  user = User.create(name: 'John', posts_counter: 0)
  post = Post.create(title: 'Title', comments_counter: 0, likes_counter: 0, author: user)

  comment1 = post.comments.create(user: user, text: 'Comment 1', created_at: 1.day.ago)
  comment2 = post.comments.create(user: user, text: 'Comment 2', created_at: 2.days.ago)
  comment3 = post.comments.create(user: user, text: 'Comment 3', created_at: 3.days.ago)

  expected_comments = [comment3, comment2, comment1].sort_by(&:created_at).reverse

  actual_comments = post.recent_comments

  expect(actual_comments).to eq(expected_comments)
end



end

end
