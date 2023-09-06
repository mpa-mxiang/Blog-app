require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  before do
    @user = User.create(name: 'Test User', bio: 'User Bio')
    @post = Post.create(author: @user, title: 'Test Post', text: 'Post Text')
  end

  it "displays the post's title, author, comments, and likes" do
    visit user_post_path(@user, @post)
    expect(page).to have_content('Test Post')
    expect(page).to have_content('Test User')
    expect(page).to have_content('Post Text')
  end

  it "redirects to the user's show page when the author's name is clicked" do
    visit user_post_path(@user, @post)

    puts user_post_path(@user, @post)
    puts user_posts_path(@user, @post)

    click_link 'Test User'
    expect(current_path).to eq(user_path(@user))
  end
end
