require 'rails_helper'

RSpec.describe "Post Show Page", type: :feature do
  before do
    @user = User.create(name: 'Test User', bio: 'User Bio')
    @post = @user.posts.create(title: 'Test Post', text: 'Post Text')
  end

  it "displays the post's title, author, comments, and likes" do
    visit post_path(@post)
    expect(page).to have_content('Test Post')
    expect(page).to have_content('Test User') 
    expect(page).to have_content('Post Text')
  end

  it "redirects to the user's show page when the author's name is clicked" do
    visit post_path(@post)
    click_link 'Test User'
    expect(current_path).to eq(user_path(@user))
  end
end
