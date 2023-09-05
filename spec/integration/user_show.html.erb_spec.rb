require 'rails_helper'

RSpec.describe "User Show Page", type: :feature do
  before do
    @user = User.create(name: 'Test User', bio: 'User Bio', photo:'https://thispersondoesnotexist.com/')
    # Create some posts for the user if needed
  end

  it "displays the user's profile picture, username, bio" do
    visit root_path(@user)
    expect(page).to have_css("img[src*='test_user_photo.jpg']")
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.bio)
  end

  it "displays the number of posts the user has written" do
    # Create some posts for the user
    @user.posts.create(title: 'Post 1', text: 'Text 1')
    @user.posts.create(title: 'Post 2', text: 'Text 2')
    visit root_path(@user)
    expect(page).to have_content("Posts: 2")
  end

  it "displays the first 3 posts of the user" do
    # Create some posts for the user
    @user.posts.create(title: 'Post 1', text: 'Text 1')
    @user.posts.create(title: 'Post 2', text: 'Text 2')
    @user.posts.create(title: 'Post 3', text: 'Text 3')
    @user.posts.create(title: 'Post 4', text: 'Text 4')
    visit root_path(@user)
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    expect(page).to have_content('Post 3')
    expect(page).not_to have_content('Post 4')
  end

it "redirects to the post's show page when a post is clicked" do
    visit root_path(@user)
    click_link_or_button 'Test Post', wait: 10
    expect(current_path).to eq(post_path(@post))
  end
  
  it "redirects to the user's post index page when 'View All Posts' is clicked" do
    visit root_path(@user)
    click_link_or_button 'View All Posts', wait: 10
    expect(current_path).to eq(user_posts_path(@user))
  end
  
end
