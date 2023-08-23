require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "renders the index template" do
      get posts_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include("All Posts")
    end
  end

  describe "GET /posts/:id" do
    it "renders the show template" do
      post = create(:post) # Assuming you have a Factory Bot factory for Post
      get post_path(post)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(post.title)
    end
  end
end
