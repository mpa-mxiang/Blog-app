require 'rails_helper'

RSpec.describe "User Post Index Page", type: :feature do
  before do
    @user = User.create(name: 'Test User', bio: 'User Bio')
    # Create some posts and comments for the user if needed
  end

  it "displays the user's profile picture, username, and number of posts" do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src*='test_user_photo.jpg']")
    expect(page).to have_content(@user.name)
    expect(page).to have_content("Posts: #{user.posts.count}")
  end

  it "displays a post's title, body, and comments" do
    # Create a post with comments for the user
    post = @user.posts.create(title: 'Test Post', text: 'Post Text')
    post.comments.create(user: @user, text: 'Comment 1')
    post.comments.create(user: @user, text: 'Comment 2')

    visit user_posts_path(@user)
    expect(page).to have_content('Test Post')
    expect(page).to have_content('Post Text')
    expect(page).to have_content('Comment 1')
    expect(page).to have_content('Comment 2')
  end

  it "redirects to the post's show page when a post is clicked" do
    # Create a post for the user
    post = @user.posts.create(title: 'Test Post', text: 'Post Text')
    visit user_posts_path(@user)
    click_link 'Test Post'
    expect(current_path).to eq(post_path(post))
  end

  it "displays pagination if there are more posts than fit on the view" do
    # Create more posts for the user than what fits on a single page
    10.times do |i|
      @user.posts.create(title: "Post #{i}", text: "Text #{i}")
    end

    visit user_posts_path(@user)
    expect(page).to have_css('.pagination')
  end
end
