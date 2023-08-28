require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  let(:user) { User.create(name: 'Heather', photo: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80', bio: 'young beauty woman.') }
  let(:post) { Post.create(author: user, title: 'sample title', text: 'sample post') }

  describe 'GET /users/:id/posts' do
    it 'renders the index template and includes placeholder text' do
      get user_posts_path(user)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      # Update the following line to match the actual content
      expect(response.body).to include('All Posts') # Or whatever the actual content is
    end
    
  end

  describe 'GET /users/:id/posts/:id' do
    it 'renders the show template and includes placeholder text' do
      get user_post_path(user, post)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      # Update the following line to match the actual content
      expect(response.body).to include('Post Details') # Or whatever the actual content is
    end
    
  end
end
