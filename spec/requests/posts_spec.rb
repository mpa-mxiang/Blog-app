require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    it 'returns a successful response' do
      get posts_url
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get posts_url
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get posts_url
      expect(response.body).to include('Sample Title')
      expect(response.body).to include('Sample Text')
    end
  end

  describe 'GET /posts/:id' do
    let(:post) { Post.create(title: 'Sample Title', text: 'Sample Text') }

    it 'returns a successful response' do
      get post_url(post)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get post_url(post)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get post_url(post)
      expect(response.body).to include('Sample Title')
      expect(response.body).to include('Sample Text')
    end
  end
end
