require 'rails_helper'

RSpec.describe "User Index Page", type: :feature do
  before do
    # Create some sample users in the database
    @user1 = User.create(name: 'User 1', bio: 'Bio 1', photo:'https://thispersondoesnotexist.com/')
    @user2 = User.create(name: 'User 2', bio: 'Bio 2', photo:'https://thispersondoesnotexist.com/')
  end

  it "displays the username of all other users" do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it "displays the profile picture for each user" do
    visit users_path
    expect(page).to have_css("img[src*='https://thispersondoesnotexist.com/']")
    expect(page).to have_css("img[src*='https://thispersondoesnotexist.com/']")
  end

  it "displays the number of posts each user has written" do
    # Create some posts for the users
    @user1.posts.create(title: 'Post 1', text: 'Text 1')
    @user2.posts.create(title: 'Post 2', text: 'Text 2')
    visit users_path
    expect(page).to have_content("Posts: 1")
    expect(page).to have_content("Posts: 1")
  end

  it "redirects to the user's show page when clicked" do
    visit users_path
    click_link @user1.name
    expect(current_path).to eq(user_path(@user1))
  end
end
